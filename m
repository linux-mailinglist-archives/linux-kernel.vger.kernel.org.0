Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DB6A233
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 08:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfGPGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 02:21:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:60171 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfGPGVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:21:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6G6LEHB010814;
        Tue, 16 Jul 2019 01:21:16 -0500
Message-ID: <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Tue, 16 Jul 2019 16:21:14 +1000
In-Reply-To: <20190716060430.GB29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
         <20190716004649.17799-2-benh@kernel.crashing.org>
         <20190716060430.GB29414@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 08:04 +0200, Christoph Hellwig wrote:
> > 
> > +		/*
> > +		 * If our IO queue size isn't the default, update the setting
> > +		 * in CC:IOSQES.
> > +		 */
> > +		if (ctrl->iosqes != NVME_NVM_IOSQES) {
> > +			ctrl->ctrl_config &= ~(0xfu << NVME_CC_IOSQES_SHIFT);
> > +			ctrl->ctrl_config |= ctrl->iosqes << NVME_CC_IOSQES_SHIFT;
> > +			ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC,
> > +						     ctrl->ctrl_config);
> > +			if (ret) {
> > +				dev_err(ctrl->device,
> > +					"error updating CC register\n");
> > +				goto out_free;
> > +			}
> > +		}
> 
> Actually, this doesn't work on a "real" nvme controller, to change CC
> values the controller needs to be disabled.

Not really. The specs says that MPS, AMD and CSS need to be set before
enabling, but IOCQES and IOSQES can be modified later as long as there
is no IO queue created yet.

This is necessary otherwise there's a chicken and egg problem. You need
the admin queue to do the controller id in order to get the sizes and
for that you need the controller to be enabled.

Note: This is not a huge issue anyway since I only update the register
if the required size isn't 6 which is probably never going to be the
case on non-Apple HW.

>   So back to the version
> you circulated to me in private mail that just sets q->sqes and has a
> comment that this is magic for The Apple controller.  If/when we get
> standardized large SQE support we'll need to discover that earlier or
> do a disable/enable dance.  Sorry for misleading you down this road and
> creating the extra work.  

I think it's still ok, let me know...

Ben.

