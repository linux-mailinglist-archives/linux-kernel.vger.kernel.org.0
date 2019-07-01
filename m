Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFE35147
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFDUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 16:43:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43214 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfFDUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:43:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x54KhSur007091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jun 2019 16:43:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D6003420481; Tue,  4 Jun 2019 16:43:27 -0400 (EDT)
Date:   Tue, 4 Jun 2019 16:43:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
Message-ID: <20190604204327.GB3231@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20190530135317.3c8d0d7b@lwn.net>
 <20190601154248.GA17800@mit.edu>
 <20190604130837.24ea1d7b@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604130837.24ea1d7b@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:08:37PM -0600, Jonathan Corbet wrote:
> On Sat, 1 Jun 2019 11:42:48 -0400
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > Finally, I'm bit concerned about anything which states absolutes,
> > because there are people who tend to be real stickler for the rules,
> > and if they see something stated in absolute terms, they fail to
> > understand that there are exceptions that are well understood, and in
> > use for years before the existence of the document which is trying to
> > codify best practices.
> 
> Hence the "there are exceptions" text at the bottom of the document :)
> 
> Anyway, I'll rework it to try to take your comments into account.  Maybe
> we should consistently say "rebasing" for changing the parent commit of a
> patch set, and "history modification" for the other tricks...?

Those names sound good to me.   Thanks!!

							- Ted
