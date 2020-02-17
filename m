Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CCE160B15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBQGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgBQGuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:50:10 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D438206F4;
        Mon, 17 Feb 2020 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581922209;
        bh=JQkGABFIlQvovIOqkHT6E9MfymQLa5WbIAQSz1frL8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wewM8cUXYNBtHnbaBTtlKip2k3vbkwfSAehaBTQ+s1MlGPUGEYIRLhQiZ9HWEI7Kr
         NbLPaM2CK1h+RXAUWuCB53d26IBi38Lw6prqtolmZK9HFKh90ZXH+LiFhH+Z/dMnpf
         0iewJnlk3xjqv+U/2fkibUEx81PEodbzvMzn7aAI=
Date:   Mon, 17 Feb 2020 14:50:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl: imx: make gpt node name generic
Message-ID: <20200217065003.GA7973@dragon>
References: <1581562380-26065-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581562380-26065-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:52:56AM +0800, Anson Huang wrote:
> Node name should be generic, use "timer" instead of "gpt" for gpt node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all by squashing them into one patch.  Thanks.

Shawn
