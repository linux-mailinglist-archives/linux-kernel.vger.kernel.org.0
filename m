Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23F887E37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436755AbfHIPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:39:34 -0400
Received: from 8bytes.org ([81.169.241.247]:48598 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436715AbfHIPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:39:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F27853D0; Fri,  9 Aug 2019 17:39:32 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:39:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
Message-ID: <20190809153931.GG12930@8bytes.org>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808101707.16783-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:17:07PM +0800, Kai-Heng Feng wrote:
> Raven Ridge systems may have malfunction touchpad or hang at boot if
> incorrect IVRS IOAPIC is provided by BIOS.
> 
> Users already found correct "ivrs_ioapic=" values, let's put them inside
> kernel to workaround buggy BIOS.

Will that still work when a fixed BIOS for these laptops is released?


	Joerg
