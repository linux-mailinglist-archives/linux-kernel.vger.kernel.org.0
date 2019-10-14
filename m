Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC7D5AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfJNFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 01:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfJNFoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:44:32 -0400
Received: from dragon (unknown [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE4920873;
        Mon, 14 Oct 2019 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571031872;
        bh=vsklJ1aQIJVTHMMlcpWk6UVcFsa6nZxkigPpSNGLoPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJTlJ0ei+XSYfi5w86FMeEP3FwZCWIEK5XG4Ck1AExRX6QwB/c3Hc7gHcWNj6xiVa
         pHMnADLsucAoI2OFlRqUXAp7gQAwZvb9iOTeTYdhEaKjjilBQ1MSEv4TfKcwliYmHA
         Y9nK1KBOlZ7b8Mijykl/9WIxip19yWORiwlIaQyQ=
Date:   Mon, 14 Oct 2019 13:44:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: Correct CPU core idle state name
Message-ID: <20191014054416.GA12262@dragon>
References: <20190917073357.5895-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917073357.5895-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:33:56PM +0800, Ran Wang wrote:
> lx2160a support PW15 but not PW20, correct name to avoid confusing.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
