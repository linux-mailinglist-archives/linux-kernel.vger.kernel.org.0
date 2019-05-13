Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00381AFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 07:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfEMFO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 01:14:28 -0400
Received: from mx1.cock.li ([185.10.68.5]:53125 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfEMFO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 01:14:28 -0400
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557724464; bh=xUxvyDs6/5Faw+V5uDyUv2qxk/T1Hixe5Md1p7cOMPM=;
        h=Date:From:To:Subject:From;
        b=b0VE/YeA5FpYO275GE0REyyjLQNKb+aVQ/gGTrvJulmkoG4aIlxarJcBnBKZGKVS6
         0WeL1nru3BdBda7RsLAlqfV/v8FwgUGvR8I6V9aZa3/XZbsWsmk9UIlEP5N7n6oDf9
         bPweQ7f742DvABHlb3rf0G0ZkiCZetuFffKqcBIuZbHd4yx5gaMswu+s+lF1d4XkAD
         etwX/fQjaPl/95AWjYneWyKaY8yvciZJSjyhT5xvE5VoIMdgqRaiZKzxcmHdyhvZ9g
         3c0E/3/fDj8w93EC8M0x7krIrUTmRdchKy9qe43V/ca37jEoSdH35KtfVVtnVCgZ6U
         pEMn/QtdNFOZA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 05:14:24 +0000
From:   informator@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: [License-discuss] Can a contributor take back open source code ? -
 Yes, if he has not signed over the copyright.
Message-ID: <93d470e7054eb9268179b60bc567e95e@redchan.it>
X-Sender: informator@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kevin.
> but there is no path which would force the project to do so.
This is incorrect.

> If the contributions were legitimately provided under an OSI-approved 
> (or similar) license, the license cannot be terminated for convenience.
This is also incorrect. Free non-exclusive licenses can be terminated 
at-will by the copyright owner. A non-exclusive license, in and of 
itself, confers no enforceable rights against the grantor without being 
merged into a contract - regardless of whatever assertions are made in 
the text.

The very quality that makes opensource attractive makes any attempt to 
create a mutually enforceable agreement an artifice - and one that will 
fail.

(And, Yes I am an attorney)


----
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


