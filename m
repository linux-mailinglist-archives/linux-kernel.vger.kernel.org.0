Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05014321D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgATTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 14:23:56 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:42938 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgATTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:23:56 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C22AF20027;
        Mon, 20 Jan 2020 20:23:53 +0100 (CET)
Date:   Mon, 20 Jan 2020 20:23:52 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
Message-ID: <20200120192352.GA11215@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-2-sam@ravnborg.org>
 <CAMuHMdVP4UwGYuNcOphPO9F2pSCaHS1j-ODxYrv_LNOoo_4coA@mail.gmail.com>
 <20200120184804.GA7630@ravnborg.org>
 <CAMuHMdWR-EY+yBaOu_pL=5mfwi=ra76YwTt5d+GZ3Qy-e7Evzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWR-EY+yBaOu_pL=5mfwi=ra76YwTt5d+GZ3Qy-e7Evzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=VZIKxcGt61bTQAzRVQQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert.

> > It is on my TODO list to make a mipi-dbi driver that in the future
> > replaces the auxdisplay driver for hd44780.
> 
> Please note that hd44780 is a character controller.
Directory was correct - but name was wrong.
It is cfag12864b I have on my TODO.

And yes, the code for hd44780 is similar. The name was familiar
because I also looked at this driver back then.

	Sam
