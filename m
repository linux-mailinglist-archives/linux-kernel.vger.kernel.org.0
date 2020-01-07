Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBC1334F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgAGVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:37:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41902 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgAGVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:37:32 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007LbO2H004276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:37:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 563A24207DF; Tue,  7 Jan 2020 16:37:24 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:37:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] random: convert to ENTROPY_BITS
Message-ID: <20200107213724.GP3619@mit.edu>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
 <20190607182517.28266-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182517.28266-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:25:14PM -0400, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to enhance code readability.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied with bits that no longer are applicable.  Also, this patch as
nothing at all with DEFINE_SHOW_ATTRIBUTE, so I dropped that from the
description.

	       	    			      	- Ted
