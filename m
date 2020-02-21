Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DBF168864
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBUUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 15:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgBUUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:39:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59C6206ED;
        Fri, 21 Feb 2020 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582317562;
        bh=iFpxCXahOm+Huyl+tdh+yOz0saRHL121VOOf55/Fl84=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yYut7r/2lMYD6zVd5DKrH8eWiiwi7bW7JK5OK2UKe51taZ9/U/7DSjoryu0mWjiyK
         SwNK4YkVA8KCPE6/FXEGYC6Auc3X3n4pMT7xIZPdPT4pQzvPciN0/gCSpvTmP1ZRuk
         z16RGnn1gk6QSNpeioxb5c++y4esi4e60deMas2k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80E9B35226DB; Fri, 21 Feb 2020 12:39:22 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:39:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20200221203922.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125112754.25223-13-qais.yousef@arm.com>
 <20191127214725.GG2889@paulmck-ThinkPad-P72>
 <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
 <20191128170025.ii3vqbj4jpcyghut@e107158-lin.cambridge.arm.com>
 <20191128210246.GJ2889@paulmck-ThinkPad-P72>
 <20191129091344.hf5demtjytv5dw5q@e107158-lin.cambridge.arm.com>
 <20191129203856.GN2889@paulmck-ThinkPad-P72>
 <20200220153159.mzpagvbwptxlehvd@e107158-lin.cambridge.arm.com>
 <20200221002616.GB2935@paulmck-ThinkPad-P72>
 <20200221093505.wcg3e47iojxefa3p@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221093505.wcg3e47iojxefa3p@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:35:05AM +0000, Qais Yousef wrote:
> On 02/20/20 16:26, Paul E. McKenney wrote:
> > > I'm taking that as reviewed-by, which I'll add to v3. Please shout if you still
> > > need to have a look further.
> > > 
> > > Once this is taken I'll add the suggested API!
> > 
> > OK, I will bite...
> > 
> > Why not right now?
> 
> Sigh. Good question. Probably I'm just being lame; it just felt the series is a
> bit fragile spanning that many archs and was wary introducing some extra
> changes on top will make it even harder to get merged soon.
> 
> Let me go and do it. You're probably right and it shouldn't really create a big
> ripple on the series.

Very good, thank you!

							Thanx, Paul
