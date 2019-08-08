Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666C585EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbfHHJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 05:47:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:47:11 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hvf0l-0004Ss-Pv; Thu, 08 Aug 2019 11:47:07 +0200
Message-ID: <1565257627.3656.6.camel@pengutronix.de>
Subject: Re: [PATCH v2] firmware: arm_scmi: Use
 {get,put}_unaligned_le{32,64} accessors
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 08 Aug 2019 11:47:07 +0200
In-Reply-To: <20190807173739.5939-1-sudeep.holla@arm.com>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
         <20190807173739.5939-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 18:37 +0100, Sudeep Holla wrote:
> Instead of type-casting the {tx,rx}.buf all over the place while
> accessing them to read/write __le{32,64} from/to the firmware, let's
> use the existing {get,put}_unaligned_le{32,64} accessors to hide all
> the type cast ugliness.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
