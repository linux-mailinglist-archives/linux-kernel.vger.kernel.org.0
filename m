Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86804D62ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfJNMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 08:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfJNMtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:49:08 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACAA20673;
        Mon, 14 Oct 2019 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571057348;
        bh=Mv+8RO/f9Lckl8079OLG7AxGYv4LcZhS1BTN4z7pAHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYn4a3dbfskzkrK+eqCKKlfM4wJxeu4Xrk1wI3mV16iOpq5BueEQiQj5oE0N6Ele3
         O99IGZZ9048NUm3wrvuTdSypEyHjHfR5dEfzEQtIQSPS/cjsVgkaXmu8T9CF+ZjRBo
         u2JudmZ+VpmnYmUHgQrkIi4fQVRkunQYxHEpPXVg=
Date:   Mon, 14 Oct 2019 20:48:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Message-ID: <20191014124849.GR12262@dragon>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:15:59AM +0800, Anson Huang wrote:
> The SCU firmware does NOT always have return value stored in message
> header's function element even the API has response data, those special
> APIs are defined as void function in SCU firmware, so they should be
> treated as return success always.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
