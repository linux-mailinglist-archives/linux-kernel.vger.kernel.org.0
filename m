Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D25A58BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfIBOE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:04:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfIBOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:04:26 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i4mwS-0005iW-D9; Mon, 02 Sep 2019 16:04:24 +0200
Message-ID: <1567433063.3666.7.camel@pengutronix.de>
Subject: Re: [PATCH v1] reset: Remove copy'n'paste redundancy in the comments
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Sep 2019 16:04:23 +0200
In-Reply-To: <20190902131920.GK2680@smile.fi.intel.com>
References: <20190819105252.81020-1-andriy.shevchenko@linux.intel.com>
         <20190902131920.GK2680@smile.fi.intel.com>
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

Hi Andy,

On Mon, 2019-09-02 at 16:19 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2019 at 01:52:52PM +0300, Andy Shevchenko wrote:
> > It seems the commit bb475230b8e5
> > ("reset: make optional functions really optional")
> > brought couple of redundant lines in the comments.
> > 
> > Drop them here.
> 
> Any comment on this?

No, this looks correct to me. Thank for the patch!
Applied to reset/next.

regards
Philipp
