Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6217AD1D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 01:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfJIXuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 19:50:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730955AbfJIXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570665015;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAtqhT5ONsjqWUWONs3upOQbCcX6WU5MkOT7sl7Bewo=;
        b=I3G816pIrs5JzNswH8L+jg79EoPY0ZBz4gJVEMxnRSCdz/uvZh9bwsSGYPFqBA1tYXdlEz
        Gp+8G3K47wZHXAo9D8Poj8yTZMaO5lvilRgpdwYs16iXQRrCyX5uEILYoJSC7D+kVgzubP
        88tSYzqOeI+s3FtBBYZcMe1lK9iMBB8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-_y_RH_CvP06kFIOVtWUGfQ-1; Wed, 09 Oct 2019 19:50:14 -0400
Received: by mail-io1-f72.google.com with SMTP id r13so6721800ioj.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=focIOQfcQNyrOXPkI531vbndDZb3WURIChJxW2xJzLs=;
        b=UWP1B+81rqEk5+uFAvbBxMvRR6IZCBOtCtdD7ND/1GicL+7FffFBPBWScXQIlsc9oU
         TOgrbc8AhbNIaNryhogLH9TsybtLE7P0mqBJx2PqqbgEDIdlsAT6ieDaDMZQIh9ET7RU
         dYo3SgfbyXsKG2RgmjP55sZnT0mDK6jdA7szpg0VeRc9N6rtMAmxKsTaT/hCMoNZFp9d
         vno/uC2fW5GJvLbo7eP6BxoSGyA3DWxDqGlDmASdIVsImRz9pvUVusN6QEcH09wK+h3+
         FBFJKDRy+9VVdsceiXaBpBAlYYaxVvXnCeSrfTAGxwHzWv0Ttqf+QD/czDssr+smshD2
         nwVQ==
X-Gm-Message-State: APjAAAVvJeg/WpDfMxQJwPnc8WMU1lZVj/lI1PrCkpy9kxEWpRy3t6je
        ubkirhARJ3QxFhz8Plvvp0NFRH3aG5jO3nYGT8Y3rNFQUb1cTe6+fwJ8zo+jUdn/pWE1jkhe7v7
        MPIAsNpPjTwcijzkXQFd8+ABC
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491126iot.209.1570665013831;
        Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBHaFMxZO0WJshtgxh7/OOthnkRt0Ri0Ng2qxBJgBmVLrUfw4ehvtKeNCwBnq7zLTnWQxQQg==
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491111iot.209.1570665013586;
        Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f23sm2553411ioc.36.2019.10.09.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:50:12 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:50:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Message-ID: <20191009235009.a3mxw4qrklkqwuzf@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: _y_RH_CvP06kFIOVtWUGfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 09 19, Bjorn Helgaas wrote:
>From: Bjorn Helgaas <bhelgaas@google.com>
>
>I think intel-iommu.c depends on CONFIG_AMD_IOMMU in an undesirable way:
>
>When CONFIG_INTEL_IOMMU_SVM=3Dy, iommu_enable_dev_iotlb() calls PRI
>interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
>implemented when CONFIG_PCI_PRI is enabled.  If CONFIG_PCI_PRI is not
>enabled, there are stubs that just return failure.
>
>The INTEL_IOMMU_SVM Kconfig does nothing with PCI_PRI, but AMD_IOMMU
>selects PCI_PRI.  So if AMD_IOMMU is enabled, intel-iommu.c gets the full
>PRI interfaces.  If AMD_IOMMU is not enabled, it gets the PRI stubs.
>
>This seems wrong.  The first patch here makes INTEL_IOMMU_SVM select
>PCI_PRI so intel-iommu.c always gets the full PRI interfaces.
>
>The second patch moves pci_prg_resp_pasid_required(), which simply returns
>a bit from the PCI capability, from #ifdef CONFIG_PCI_PASID to #ifdef
>CONFIG_PCI_PRI.  This is related because INTEL_IOMMU_SVM already *does*
>select PCI_PASID, so it previously always got pci_prg_resp_pasid_required(=
)
>even though it got stubs for other PRI things.
>
>Since these are related and I have several follow-on ATS-related patches i=
n
>the queue, I'd like to take these both via the PCI tree.
>
>Bjorn Helgaas (2):
>  iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
>  PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI
>
> drivers/iommu/Kconfig   |  1 +
> drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
> include/linux/pci-ats.h | 11 ++++-----
> 3 files changed, 31 insertions(+), 36 deletions(-)
>
>--=20
>2.23.0.581.g78d2f28ef7-goog
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

