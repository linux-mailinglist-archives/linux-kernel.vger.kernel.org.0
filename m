Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB62B6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE0Nuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:50:44 -0400
Received: from 8bytes.org ([81.169.241.247]:40242 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfE0Nuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:50:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 046B22F9; Mon, 27 May 2019 15:50:42 +0200 (CEST)
Date:   Mon, 27 May 2019 15:50:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/amd: make iommu_disable safer
Message-ID: <20190527135041.GD8420@8bytes.org>
References: <20190517005242.20257-1-kevmitch@arista.com>
 <20190517005242.20257-2-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517005242.20257-2-kevmitch@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, May 16, 2019 at 05:52:40PM -0700, Kevin Mitchell wrote:
> Signed-off-by: Kevin Mitchell <kevmitch@arista.com>

somehow I didn't receive the cover letter and patch 3 of this set, can
you please re-send so I have it all for review?

Regards,

	Joerg
