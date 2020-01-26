Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6011B149CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 22:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAZV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 16:26:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60797 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgAZV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:26:28 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00QLQKr6014139
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jan 2020 16:26:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E98FE420324; Sun, 26 Jan 2020 16:26:19 -0500 (EST)
Date:   Sun, 26 Jan 2020 16:26:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: delayed "random: get_random_bytes" line in dmesg
Message-ID: <20200126212619.GA13716@mit.edu>
References: <a4d06aa4-30df-4333-6b94-46fa95e32129@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4d06aa4-30df-4333-6b94-46fa95e32129@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 03:41:24PM +0100, Toralf F�rster wrote:
> I do wonder a little bit about the timestamp of the "random: get_random_bytes" near the end b/c it is way delayed, or?

The get_random_bytes call in setup_net is used to initialize value
returned by net_hash_mix() for the root net namespace.  So if that's
not super random, an attacker might be able to use that to leverage
kernel level attacks.  It's at least not being used for a
cryptographic purpose, though.

> Linux mr-fox 5.4.15 #6 SMP Sun Jan 26 10:07:17 CET 2020 x86_64 Intel(R) Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux

The E5-1650 is a (roughly) eight year old chip with the Sandy Bridge
architecture, and that was the last architecture _not_ to support
RDRAND.

						- Ted

