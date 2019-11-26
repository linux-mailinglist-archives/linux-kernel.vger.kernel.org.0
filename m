Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DDB109E38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKZMqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 07:46:43 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:61599 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKZMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:46:43 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MkDc4hXJz1Gry;
        Tue, 26 Nov 2019 07:46:40 -0500 (EST)
Date:   Tue, 26 Nov 2019 04:46:39 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Kirill Smelkov <kirr@nexedi.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
In-Reply-To: <20191126100010.GA15941@deco.navytux.spb.ru>
Message-ID: <alpine.DEB.2.21.1911260445170.6292@hp-x360n>
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com> <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com> <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
 <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com> <20191126100010.GA15941@deco.navytux.spb.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Nov 2019, Kirill Smelkov wrote:

> P.S. even though I was put into cc there, somehow I did not received any
> notification email for commits d8e464ecc17b (vfs: mark pipes and sockets as
> stream-like file descriptors) and 0be0ee71816b (vfs: properly and
> reliably lock f_pos in fdget_pos()).

That's my fault; the CC: list for those commits was pretty long and I was
worried about it appearing like SPAMming anyone who'd signed off on it, so
I'd punted and sent it to Linus and the LKML only.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
