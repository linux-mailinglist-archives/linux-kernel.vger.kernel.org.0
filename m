Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACDD37F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 05:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfJKDrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 23:47:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKDrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:47:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so3802332plj.10;
        Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lwaGexEIk4Tlv5FRwTaoLvYkPu+sAPH7np80Oye+n20=;
        b=Tv2D/j9IhiVwpOomkMei9mX/yftFh3M+jMXDqPObnbTzNhkl3Vbwz8nfJt804LsPWh
         IciDobUmz3EIfjwukLWZxWxft7TKG+lQlr1HIcNDIM95T5GmFnxBh0PykfqcZUF7nGuJ
         st/oFLIiOnlYOIsi/QPu+nMU9JawJsEhsXlo7oBSWtOMGGgZplUJRBzKreEHEFhxtKnF
         kIENpylMwCncC7haXNujmrB+OKFJ0oMJFyyhOZW+jCRvJpupe0S8Wr3g0q9X106g2d15
         vGR81cJiKSNy/G4YPrbEaW/YduaOG9S5kuIaOYGcKC5oHBox9NzEtg9IAVveiZnhtEAT
         HDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lwaGexEIk4Tlv5FRwTaoLvYkPu+sAPH7np80Oye+n20=;
        b=aBCiQn1M4zMNaGgN/LPKwfkTTKpa4+l6uJcZopQiRv1kCRJzQEXSwtfbcv2+BCcL8T
         8WSLPP1QNs41v0HU+IaG9bAuRjNn6WUuVN2RgIQP9/blgGXWQRqZnCwdwdHxX9IAJ7Uj
         jcbltYxZSfZiV3IPKihdEzCZd6eqDCXGUbP8quqzuoeR0o7Ca5uKen6y2bfTUst9U5wX
         lymhx1CIl33nh38s2vg8B3xUM88eDFcZb6C1iu4SXtOjHrbklsgCvOqs4auZzqBIx5xY
         TVTblmwgzWy/3hRu7Q5JwD/pTOEABMhQ7L41VR8Xlt5rPd7lnxsqIePb81pKirCt39zu
         mLnw==
X-Gm-Message-State: APjAAAUwa6h1aV78WIzihlO/o9GMKvFsLlL1vkDmwE2Xk0iaotKwJYM2
        K3Km4lgj2sjL1UuyCMMyrjc=
X-Google-Smtp-Source: APXvYqyR1rmTzHQKhSUn3T3BkL6TnScR8FJqXArtRUVHc2yY16j/jZMdOqQe/IiJJA8w+1/i2ZTwMg==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21mr4891378pls.49.1570765634586;
        Thu, 10 Oct 2019 20:47:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u3sm7493267pfn.134.2019.10.10.20.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:47:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will@kernel.org, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size" property
Date:   Thu, 10 Oct 2019 20:46:07 -0700
Message-Id: <20191011034609.13319-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add an optional DT property to allow an SoC to
specify how many bits being physically connected to its SMMU instance,
depending on the SoC design.

Nicolin Chen (2):
  dt-bindings: arm-smmu: Add an optional "input-address-size" property
  iommu/arm-smmu: Read optional "input-address-size" property

 Documentation/devicetree/bindings/iommu/arm,smmu.txt |  7 +++++++
 drivers/iommu/arm-smmu.c                             | 10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.17.1

