Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310DE1998C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgCaOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:41:26 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34220 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCaOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:41:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02VEfNqS024749;
        Tue, 31 Mar 2020 16:41:23 +0200
Date:   Tue, 31 Mar 2020 16:41:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Backport dependencies helper
Message-ID: <20200331144123.GA24745@1wt.eu>
References: <20200331123217.GM4189@sasha-vm>
 <20200331134400.GA24671@1wt.eu>
 <20200331140830.GN4189@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331140830.GN4189@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:08:30AM -0400, Sasha Levin wrote:
> No, those tools try to do the same thing, but work differently.
> stable-deps attempts to look at context lines surrounding the patch
> itself to guess which other patches might be interesting.

OK!

> While here, I use git-bisect to create a list of commits required to be
> applied before any given commit.

I see, this sounds like a great idea!

Thanks,
Willy
