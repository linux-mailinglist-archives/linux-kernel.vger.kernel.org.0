Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0113359B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 23:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgAGWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 17:20:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48911 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgAGWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:20:44 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007MKZlC018970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 17:20:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65E1D4207DF; Tue,  7 Jan 2020 17:20:35 -0500 (EST)
Date:   Tue, 7 Jan 2020 17:20:35 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] random: remove some dead code of poolinfo
Message-ID: <20200107222035.GB172530@mit.edu>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
 <20190607182517.28266-5-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182517.28266-5-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:25:17PM -0400, Yangtao Li wrote:
> Since it is not being used, so delete it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied, thanks.  I also dropped the 32-word poolinfo definition since
we've dropped the /dev/random blocking pool.  (We only need the 128
word poolinfo now for the 4 kbit input pool.)

					- Ted
