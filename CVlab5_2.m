he = imread('C:\Users\DELL\OneDrive - Loughborough University\Attachments\sunxiaochuan.jpg');

cform = makecform('srgb2lab');
lab_he = applycform(he,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end


mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = imbinarize(L_blue);

nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = he;
blue_nuclei(nuclei_labels ~= 1) = 0;

figure,subplot(2,3,1),imshow(he), title('original image');subplot(2,3,2),imshow(pixel_labels,[]), title('image labeled by cluster index');
subplot(2,3,3),imshow(segmented_images{1}), title('objects in cluster 1');
subplot(2,3,4),imshow(segmented_images{2}), title('objects in cluster 2');
subplot(2,3,5),imshow(segmented_images{3}), title('objects in cluster 3');subplot(2,3,6),imshow(blue_nuclei), title('final');
