Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31AE1097AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfKZCDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:03:23 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:65496 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKZCDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:03:23 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MRyL5131zvhM;
        Mon, 25 Nov 2019 21:03:22 -0500 (EST)
Date:   Mon, 25 Nov 2019 18:03:21 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
In-Reply-To: <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911251802340.5332@hp-x360n>
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com> <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Nov 2019, Linus Torvalds wrote:

> So to get rid of at least _that_ endless noise, add this to the patch:

Thanks for the update; I'll get to test this later tonight (US Pacific time).

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
