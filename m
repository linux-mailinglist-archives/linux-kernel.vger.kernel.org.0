Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97DC13476C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgAHQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:14:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53204 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727428AbgAHQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:14:41 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 008GEYjR019743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Jan 2020 11:14:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0F2E94207DF; Wed,  8 Jan 2020 11:14:29 -0500 (EST)
Date:   Wed, 8 Jan 2020 11:14:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Enrico Weigelt <lkml@metux.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Improving documentation for programming interfaces
Message-ID: <20200108161428.GA263696@mit.edu>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
 <17931ddd-76ec-d342-912c-faed6084e863@metux.net>
 <748b8572-a3b3-c084-e8e3-de420f53e468@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748b8572-a3b3-c084-e8e3-de420f53e468@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 01:40:45PM +0100, Markus Elfring wrote:
> 
> I propose to encode helpful information into macro calls as needed
> for the C programming language.

Perhaps it would be useful to for you to express what you are
proposing in the form of a patch?  That way people can see how
disruptive such changes might be, and how hard it might be to maintain
them.  That's on the "cost" side of the equation.

On the "benefits" side of the equation, is there are ways in which it
will directly benefit the kernel developers who will need to review
the patches and review the annotations, that can be demonstrated
immediately?  Not in some abstract way, or "when I my research work is
completed", but a very concrete way that will be obvious to those of
us who are still not completely convinced?

If the costs are very small, then the requirement for demonstrating
great benefits will also be small.  But if the costs are large (e.g.,
widespread renaming of huge numbers of functions, adding a lot of
extra complexity into code paths, use of silly/stupid names such as
"TransactionAwarePersistenceManagerFactoryProxy"), then need to show
benefits commensurate with such costs will also be great.

	 	      	   	      - Ted
