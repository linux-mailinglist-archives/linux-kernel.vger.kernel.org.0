Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361BE191792
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCXRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:24:59 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:37800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727164AbgCXRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:24:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DDE0ADA994;
        Tue, 24 Mar 2020 17:24:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2900:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:4250:4321:5007:6119:7903:7975:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14659:14695:14721:21080:21212:21433:21627:21740:21795:21939:30003:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sleet61_653e1bf6a3242
X-Filterd-Recvd-Size: 2920
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Mar 2020 17:24:55 +0000 (UTC)
Message-ID: <1dff1b277e5d2c95ce100a2daff4967f98d074ba.camel@perches.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
From:   Joe Perches <joe@perches.com>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
Date:   Tue, 24 Mar 2020 10:23:05 -0700
In-Reply-To: <20200324170407.16470-3-arnaud.pouliquen@st.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
         <20200324170407.16470-3-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 18:04 +0100, Arnaud Pouliquen wrote:
> This driver exposes a standard TTY interface on top of the rpmsg
> framework through a rpmsg service.
> 
> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> per rpmsg endpoint.

trivial notes:

> diff --git a/Documentation/serial/tty_rpmsg.rst b/Documentation/serial/tty_rpmsg.rst
[]
> +The rpmsg tty driver implements serial communication on the RPMsg bus to makes possible for user-space programs to send and receive rpmsg messages as a standard tty protocol.

Very long text lines missing newlines?

[]
> +To be compliant with this driver, the remote firmware must create its data end point associated with the "rpmsg-tty-raw" service.
[]
> +To be compatible with this driver, the remote firmware must create or use its end point associated with "rpmsg-tty-ctrl" service, plus a second endpoint for the data flow.
> +On Linux rpmsg_tty probes, the data endpoint address and the CTS (set to disable)

[]

> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
[]
> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
> +				  u32);

unused typedef?

[]

> +static int __init rpmsg_tty_init(void)
> +{
[]
> +	err = tty_register_driver(rpmsg_tty_driver);
> +	if (err < 0) {
> +		pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
> +		goto error_put;
> +	}

Might use vsprintf extension %pe

		pr_err("Couldn't install rpmsg tty driver: %pe\n", ERR_PTR(err));

> +	err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
> +	if (err < 0) {
> +		pr_err("Couldn't register rpmsg tty driver: err %d\n", err);

etc.


