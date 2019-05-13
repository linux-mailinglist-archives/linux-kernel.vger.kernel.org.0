Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7C1AF85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 06:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEMEnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 00:43:20 -0400
Received: from mx1.cock.li ([185.10.68.5]:45675 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfEMEnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 00:43:20 -0400
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557722595; bh=jKZ6KMdNdQ581vz5QNzdIMdfzhuv0J37HqPVJEZgdfA=;
        h=Date:From:To:Cc:Subject:From;
        b=EHIOyz6/WlQfhVzO4rZBkIHnByXQUwhFQ5N5o3JF+LdNqfF2FBKn73JIdrhsiLnup
         X1qrqSjYCN3jIWSvzjETb7wMoAVD9YlqUkNiF3rsq7L9GhLfxOPAW+vbNiRCxXJ8ox
         KzQ8t+V4UKSxK79f66iYJr8gO9p3pmrMvoatAqiACcXTyeuVZrQPsZvUVJ5Iaq57lN
         Czk+9Nhm07iMxnJ/OVNLrepTM550IWECfpoGaP8i/q+km2VhO7R3GxW/odnRGo5qW9
         8ruLLomjvp4E0o4CQH3qEhRKKNXsh0yHrzKjqZpKY2M6Rma0NFp9LouEqOK+5vyVjr
         Ur4fmv6zU5y2w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 04:43:15 +0000
From:   informator@redchan.it
To:     antoine.thomas@prestashop.com
Cc:     linux-kernel@vger.kernel.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, license-discuss-owner@lists.opensource.org,
        freebsd-current@freebsd.org
Subject: [License-discuss] Can a contributor take back open source code ? -
 Yes, if he has not signed over the copyright.
Message-ID: <b9586de411c283af2f4f2132b174d537@redchan.it>
X-Sender: informator@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a "not easy" question: is it possible for a contributor to 
> remove his contributions (code, translations, ...) from an open source 
> project?

In short: Yes the copyright holder can do just that in most cases we see 
in the wild (where there is no copyright assignment and the licensees 
are free-takers).

It seems to the policy of the FSF, SFLC, etc to claim to you that 
Illusory Promises are enforceable in the US courts, or to claim that 
obeying a preexisting legal duty is valid consideration for a mutually 
enforceable agreement (contract). Obviously you have an inkling to the 
contrary since you are asking this question. Your suspicion is well 
founded, as consideration, contrary to what interested parties may want 
you to believe, is still generally a requirement for a promise to be 
held enforceable, in the US.

-----

Assuming: Contributor has not signed over his copyrights, and the entity 
did not pay consideration to the "contributor":

Yes.

Free Non-exclusive licenses are revocable.

For a promise not to revoke or to revoke only under certain 
circumstances to be binding against the grantor he must have received 
some bargained-for consideration in exchange.

"Nothing" is not valid consideration.

Offering what you are trying to contract for as "consideration" for that 
very contract is not valid consideration.

Obeying a pre-existing legal duty (not violating the copyright holder's 
copyright) is not valid consideration.

You can read a lengthy explanation for the lay person here:
lkml.org/lkml/2019/5/3/698
(and it covers the 9th circuit
Artifex case and 9th circuit Artistic License case which some people
will try to make you think invalidates your proprietary rights)
or here:
lkml.org/lkml/2019/5/4/334


Note: If you would like a nice expansive legal paper to read on this
issue, Sapna Kumar's paper is good:
scholarship.law.duke.edu/faculty_scholarship/1857/
www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
papers.ssrn.com/sol3/papers.cfm?abstract_id=243237


> And, if someone do that, is it possible for the project to continue to 
> maintain the previous version, thanks to the license? (I mean, before 
> the deletion)

No. Once the license is revoked, if the licensee cannot show that it has 
an attached interest (ie: a valid contract), by law the licensee 
no-longer has permission from the copyright owner to 
use/distribute/modify/etc the work of authorship. They may beg the court 
under equity for some accommodation, of course.


