Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018A287E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436624AbfHIPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:33:45 -0400
Received: from 8bytes.org ([81.169.241.247]:48568 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406607AbfHIPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:33:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3E5F93D0; Fri,  9 Aug 2019 17:33:44 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:33:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 22/57] iommu: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190809153342.GD12930@8bytes.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-23-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-23-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:22AM -0700, Stephen Boyd wrote:
> Please apply directly to subsystem trees

Applied, thanks.
