Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE1446C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393106AbfFMQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbfFMCw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:52:28 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24E42063F;
        Thu, 13 Jun 2019 02:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560394348;
        bh=3ZnbzvET/CCmzXdSnqVjMIjCsSRh2eJOtm9jjVCzxCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZylahy4zOH+RioPHHjT9TDoM9ta8WE3ZmL73z5VCQoPtgY8wTy4SAB8HfbKNAGkU
         B3vTTkIudMgIIR1BB5jlxl2jsHA/bdxlYCV55y8a5PT70zABSy8UASIIuOPlmkW5CI
         Q24MXluJKxj8lttKq+4dgU90nRaFWIp/annCcKAw=
Date:   Thu, 13 Jun 2019 10:51:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: ls1028a: Add temperature sensor node
Message-ID: <20190613025151.GH20747@dragon>
References: <20190611054244.35269-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611054244.35269-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 01:42:44PM +0800, Yuantian Tang wrote:
> Add nxp sa56004 chip node for temperature monitor.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks.
