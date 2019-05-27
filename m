Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D022B742
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE0OG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:06:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43057 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbfE0OG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:06:59 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4RE6h9L017645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 May 2019 10:06:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C24BB420481; Mon, 27 May 2019 10:06:43 -0400 (EDT)
Date:   Mon, 27 May 2019 10:06:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Naveen Nathan <naveen@lastninja.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kevin Easton <kevin@guarana.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: urandom reads block when CRNG is not initialized.
Message-ID: <20190527140643.GB8585@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Naveen Nathan <naveen@lastninja.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kevin Easton <kevin@guarana.org>, linux-kernel@vger.kernel.org
References: <20190527122627.GA15618@u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527122627.GA15618@u>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:26:28PM +0000, Naveen Nathan wrote:
> Adds a compile-time option to ensure urandom reads block until
> the cryptographic random number generator (CRNG) is initialized.
> 
> This fixes a long standing security issue, the so called boot-time
> entropy hole, where systems (particularly headless and embededd)
> generate cryptographic keys before the CRNG has been iniitalised,
> as exhibited in the work at https://factorable.net/.
> 
> This is deliberately a compile-time option without a corresponding
> command line option to toggle urandom blocking behavior to prevent
> system builders shooting themselves in the foot by
> accidently/deliberately/maliciously toggling the option off in
> production builds.
> 
> Signed-off-by: Naveen Nathan <naveen@lastninja.net>

This is guaranteed to cause the system to fail for systems using
systemd.  (Unless you are running an x86 with random.trust_cpu=1 ---
in which case, this patch/config is pointless.)  And many embedded
systems *do* use systemd.  I know lots of people like to wish that
systemd doesn't exist, but we need to face reality.

*Seriously,* if this is something the system builder should be using,
they should be fixing userspace.  And if they care enough that they
would want to enable this patch, they could just scan dmesg looking
for the warnings from the kernel.

						- Ted
