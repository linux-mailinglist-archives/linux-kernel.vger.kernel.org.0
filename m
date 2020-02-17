Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29115160B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 08:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgBQHbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 02:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgBQHbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:31:53 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B148F20702;
        Mon, 17 Feb 2020 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581924713;
        bh=1fLU4bpF5ge2mxDXA5uyg+zyID6wnutQys90jG2tVdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvmcvoA64BpUvrGNjy1t7QLL5WBibHOv1DPiciSJ/5LPgcs9KmjsT1Q2tKOqqahHk
         Si2KzD7OPhi1L9R1oO9DP1patXAKXQWhdk3O2idNOyxnkrXUKz3OwNYYC0A7o14W+L
         bloL4D/4jNxxap3QiDv+Ec2/vo6GvQa2hUXtmuGw=
Date:   Mon, 17 Feb 2020 15:31:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl: make kpp node name generic
Message-ID: <20200217073146.GG7973@dragon>
References: <1581646293-31096-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581646293-31096-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:11:29AM +0800, Anson Huang wrote:
> Node name should be generic, use "keypad" instead of "kpp" for kpp node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied with squashing, thanks. 
