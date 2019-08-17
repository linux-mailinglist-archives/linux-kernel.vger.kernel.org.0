Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E900912D6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfHQUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 16:42:08 -0400
Received: from mx1.riseup.net ([198.252.153.129]:46228 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfHQUmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 16:42:08 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 6DF6D1A066F;
        Sat, 17 Aug 2019 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1566074527; bh=kqYpwCVCduJTvlPzfuhw0N1x1izVQclRyEC+VVJaMKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
        b=TwH7PVWEHvmoclP6Iz35jCGgWyLP1Cloehjnf262XBJPkznwNqdOwYW81gLFB76zu
         sw1p29ffFLN1QYnb6LHmeDl91mAt2/vRsmC53nfJFzFxrVffoCJBXCdlJ35HtI/4W8
         DGzY0Sa6LuCzMvEUuf4gCMWvIXOGbsONPFqQrnaQ=
X-Riseup-User-ID: EC564BFF9A0A3597D983440FF9A562E841375695B758726481FC66AF90EF460A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 16F46120362;
        Sat, 17 Aug 2019 13:42:04 -0700 (PDT)
Date:   Sat, 17 Aug 2019 23:41:57 +0300
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Cc:     mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190817234157.5ed13261@localhost>
In-Reply-To: <alpine.DEB.2.21.1908152140460.1908@nanos.tec.linutronix.de>
References: <20190813232829.3a1962cc@localhost>
        <20190813212115.GO16770@zn.tnic>
        <20190814010041.098fe4be@localhost>
        <20190814070457.GA26456@zn.tnic>
        <20190814121154.12f488f7@localhost>
        <alpine.DEB.2.21.1908151054090.2241@nanos.tec.linutronix.de>
        <20190815223730.0b5c6c13@localhost>
        <alpine.DEB.2.21.1908152140460.1908@nanos.tec.linutronix.de>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner,

Alright. Then I guess I am wasting everyone's time and everything is as
it should be according to you.

I will unsubscribe from this mailing list because it is flooding my
mail box with so many messages and I don't know of any way to subscribe
only to this particular thread.

Please CC me if this discussion continues.
