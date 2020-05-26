Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7B19AAE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgDALiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 07:38:18 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26246 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbgDALiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:38:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031BVDwh025633;
        Wed, 1 Apr 2020 04:38:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=75nGljHVFqt0QhvENVD0hJlIui45v+CfwsYhW2bhLLk=;
 b=f237XEM4gvWf4Kr0YkFU547qWp/K/IbSwTsffiq8aHssoZzxHxIs60TGdw1y6JGpe25h
 raSeoG4yfegDaYfW1QjGQIu9CvLOR0QP194JaxefnYdftpxVcDoNy+tz4iZ0BmphN/3o
 PNI4gKNkFldy0weOOd+hFD7FUjP1seWBWQPjgmxG+8h0nDJrmtD8SN4ZPFrkMV9MqFJz
 b4W4By8Eqg2qEofT+9wbTvejvWquF42GVmOhO4B/Mmb9ESfoGNx8nbrkI5f5/atgKf1d
 up0wzSm+8TCPguAmUSlEEd+w4Zdbnmhjecj1+shqHEeJKivhg+AQpDoZ3Rns9yX/h+uD kw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3046h5w6ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 04:38:12 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Apr
 2020 04:38:10 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Apr 2020 04:38:07 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <jean-philippe@linaro.org>, <joro@8bytes.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <eric.auger.pro@gmail.com>, <eric.auger@redhat.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by endpoint
Date:   Wed, 1 Apr 2020 17:08:04 +0530
Message-ID: <20200401113804.21616-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different endpoint can support different page size, probe
endpoint if it supports specific page size otherwise use
global page sizes.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
 include/uapi/linux/virtio_iommu.h |  7 +++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index cce329d71fba..c794cb5b7b3e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -78,6 +78,7 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	u64				pgsize_bitmap;
 };
 
 struct viommu_request {
@@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 	return ret;
 }
 
+static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
+				    struct virtio_iommu_probe_pgsize_mask *mask,
+				    size_t len)
+
+{
+	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
+
+	if (len < sizeof(*mask))
+		return -EINVAL;
+
+	vdev->pgsize_bitmap = pgsize_bitmap;
+	return 0;
+}
+
 static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
@@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
 	       cur < viommu->probe_size) {
 		len = le16_to_cpu(prop->length) + sizeof(*prop);
-
 		switch (type) {
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
 			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
 			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
+			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
 		}
@@ -607,16 +624,23 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	return &vdomain->domain;
 }
 
-static int viommu_domain_finalise(struct viommu_dev *viommu,
+static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 				  struct iommu_domain *domain)
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct viommu_dev *viommu = vdev->viommu;
 
 	vdomain->viommu		= viommu;
 	vdomain->map_flags	= viommu->map_flags;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
+	/* Devices in same domain must support same size pages */
+	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
+	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
+		return -EINVAL;
+
+	domain->pgsize_bitmap = vdev->pgsize_bitmap;
+
 	domain->geometry	= viommu->geometry;
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
@@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * Properly initialize the domain now that we know which viommu
 		 * owns it.
 		 */
-		ret = viommu_domain_finalise(vdev->viommu, domain);
+		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		dev_err(dev, "cannot attach to foreign vIOMMU\n");
 		ret = -EXDEV;
@@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
+	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
 	INIT_LIST_HEAD(&vdev->resv_regions);
 	fwspec->iommu_priv = vdev;
 
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..dc9d3f40bcd8 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
 	__le16					length;
 };
 
+struct virtio_iommu_probe_pgsize_mask {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	__u64					pgsize_bitmap;
+};
+
 #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
 #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
 
-- 
2.17.1

