Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65568B763
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfHMLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 07:43:00 -0400
Received: from muru.com ([72.249.23.125]:57192 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfHMLnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:43:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AC96E805C;
        Tue, 13 Aug 2019 11:43:27 +0000 (UTC)
Date:   Tue, 13 Aug 2019 04:42:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] bus: ti-sysc: sysc_check_children(): Change
 return type to void
Message-ID: <20190813114256.GR52127@atomide.com>
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
 <20190813075553.2354-1-nishkadg.linux@gmail.com>
 <20190813075553.2354-2-nishkadg.linux@gmail.com>
 <dd6f47c8-13bc-f20e-90ce-208bd10c3bc0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6f47c8-13bc-f20e-90ce-208bd10c3bc0@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190813 11:14]:
> 
> On 13/08/2019 10:55, Nishka Dasgupta wrote:
> > Change return type of function sysc_check_children() from int to void as
> > it always returns 0. Remove its return statement as well.
> > At call site, remove the variable that was used to store the return
> > value, as well as the check on the return value.
> > 
> 
> You don't need to describe each and everything as it is obvious
> from code. How about?
> "Change return type of sysc_check_children() to "void"
> as it never returns error"
> 
> Should both patches can be squashed into one patch?

Sure why not, makes it easier to follow :)

Regards,

Tony
