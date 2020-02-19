Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5403D164139
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBSKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:09:16 -0500
Received: from 8bytes.org ([81.169.241.247]:54842 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:09:15 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A44F5346; Wed, 19 Feb 2020 11:09:14 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:09:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
Message-ID: <20200219100913.GA1961@8bytes.org>
References: <20200210075115.14838-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210075115.14838-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:51:15PM +0800, Kai-Heng Feng wrote:
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> Use identity-mapping and PCI ATS doesn't help this issue.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> the same here to avoid screen flickering on 4K monitor.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

