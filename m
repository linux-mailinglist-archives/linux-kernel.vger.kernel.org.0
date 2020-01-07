Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B79133524
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgAGVpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:45:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43205 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726594AbgAGVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:45:11 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007Lj3HN007026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:45:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A299A4207DF; Tue,  7 Jan 2020 16:45:02 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:45:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] random: Add and use pr_fmt()
Message-ID: <20200107214502.GQ3619@mit.edu>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
 <20190607182517.28266-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182517.28266-3-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:25:15PM -0400, Yangtao Li wrote:
> Prefix all printk/pr_<level> messages with "random: " to make the
> logging a bit more consistent.
> 
> Miscellanea:
> 
> o Convert a printks to pr_notice
> o Whitespace to align to open parentheses
> o Remove embedded "random: " from pr_* as pr_fmt adds it
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied with adjustments, thanks.

					- Ted
