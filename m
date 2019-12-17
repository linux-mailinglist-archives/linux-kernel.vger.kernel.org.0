Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79361227C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfLQJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 04:35:18 -0500
Received: from 8bytes.org ([81.169.241.247]:57628 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:35:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0BB7F286; Tue, 17 Dec 2019 10:35:16 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:35:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu: Fix Kconfig indentation
Message-ID: <20191217093515.GE8689@8bytes.org>
References: <1574306370-29529-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306370-29529-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:19:30AM +0100, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.
> ---
>  drivers/iommu/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
