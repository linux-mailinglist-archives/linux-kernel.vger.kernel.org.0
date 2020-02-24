Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE75816A5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgBXL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 06:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbgBXL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:59:02 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B914D20828;
        Mon, 24 Feb 2020 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582545542;
        bh=527/P0PCxAx1P3oVPckFcLKVR2UnWZl2M0CPxqoBIk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSTFUuC4JnlbirXZ+HGrAkvpP4DjdiSDsPM/8vaNQ/PdHplKpt7o8SMDP5X+QAGDZ
         XphGKVbFzlZ5C7s1+3sNbaMLp+VUtyJuONxTUP57vTEcx6ETyWOG3/n1GH4nNwOo6K
         eMFJVma+cPkZWrzifs/dc/QW0e3OmBlFzwoKoLWQ=
Date:   Mon, 24 Feb 2020 19:58:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028: sl28: explicitly enable network ports
Message-ID: <20200224115854.GG27688@dragon>
References: <20200224115052.27328-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224115052.27328-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:50:52PM +0100, Michael Walle wrote:
> Since commit b9213899d2b0 ("arm64: dts: ls1028a: disable all enetc ports
> by default") all the network ports are disabled by default. This makes
> sense, but now we have to enable them explicitly in the boards. Do so
> for the sl28 module.
> 
> Since we are at it. Make sure the second port is only enabled for the
> variant 4 of the module. Variant 3 has only one network port.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
