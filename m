Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4217A923
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCEPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:45:22 -0500
Received: from verein.lst.de ([213.95.11.211]:60036 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCEPpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:45:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A52E468B05; Thu,  5 Mar 2020 16:45:20 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:45:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 6/6] dma-remap: double the default DMA coherent pool size
Message-ID: <20200305154520.GD5332@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011538260.213582@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003011538260.213582@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:05:27PM -0800, David Rientjes wrote:
> When AMD memory encryption is enabled, some devices may used more than
> 256KB/sec from the atomic pools.  Double the default size to make the
> original size and expansion more appropriate.
> 
> This provides a slight optimization on initial expansion and is deemed
> appropriate for all configs with CONFIG_DMA_REMAP enabled because of the
> increased reliance on the atomic pools.
> 
> Alternatively, this could be done only when CONFIG_AMD_MEM_ENCRYPT is
> enabled.

Can we just scale the initial size based on the system memory size?
