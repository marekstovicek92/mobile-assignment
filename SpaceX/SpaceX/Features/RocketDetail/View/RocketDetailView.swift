//
//  RocketDetailView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct RocketDetailView: View {

    @State var viewModel: RocketDetailViewModel
    let router: RocketDetailRouter

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let detail):
                contentView(for: detail)
            case .error(let error):
                Text("Error \(error)")
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }

    private func contentView(for detail: Content) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .zero) {
                Text("Overview")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                Text(detail.description)
                Text("Parameters")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                HStack {
                    detail.height.map {
                        ValueLabelView(value: $0, label: "height")
                    }
                    detail.diameter.map {
                        ValueLabelView(value: $0, label: "diameter")
                    }
                    ValueLabelView(value: detail.mass, label: "mass")
                }

                ForEach(detail.stages) { stage in
                    RocketStageView(
                        content: stage
                    )
                    .padding(.top, 16)
                }

                detail.images.map { images in
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("Photos")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                        ForEach(images, id: \.absoluteString) { imageURL in
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.bottom, 8)
                            } placeholder: {
                                Image(systemName: "photo.artframe")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.clear)
                                    }
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
        .navigationTitle(detail.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.goToRocketLaunch) {
            router.makeLaunchView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.goToRocketLaunch = true
                } label: {
                    Text("Launch")
                }
            }
        }
    }
}

extension RocketDetailView {
    struct Content: Hashable {
        let name: String
        let description: String
        let height: String?
        let diameter: String?
        let mass: String
        let stages: [RocketStageView.Content]
        let images: [URL]?
    }
}

#Preview {
    RocketDetailView(
        viewModel: RocketDetailViewModel(
            rocketId: "",
            loadRocketDetail: RocketDetailUseCaseMock()
        ),
        router: RocketDetailRouter(launchRocketContainer: LaunchRocketContainer())
    )
}
