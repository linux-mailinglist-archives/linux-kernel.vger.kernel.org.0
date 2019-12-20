Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC50127F27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLTPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 10:19:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60324 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727233AbfLTPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:19:54 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBKFJkke015295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 10:19:49 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8749A420822; Fri, 20 Dec 2019 10:19:45 -0500 (EST)
Date:   Fri, 20 Dec 2019 10:19:45 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Improving documentation for programming interfaces
Message-ID: <20191220151945.GD59959@mit.edu>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 02:30:10PM +0100, Markus Elfring wrote:
> Linux supports some programming interfaces. Several functions are provided
> as usual. Their application documentation is an ongoing development challenge.
> 
> Now I would like to clarify possibilities for the specification of desired
> information together with data types besides properties which are handled by
> the programming language “C” so far.
> It seems that no customised attributes are supported at the moment.
> Thus I imagine to specify helpful annotations as macros.
> 
> Example:
> Some functions allocate resources to which a pointer (or handle) is returned.
> I would find it nice then if such a pointer would contain also the background
> information by which functions the resource should usually be released.
> 
> Can it become easier to determine such data?

Markus,

It's unclear to me what you are requesting/proposing?  Can you be a
bit more concrete?

						- Ted
