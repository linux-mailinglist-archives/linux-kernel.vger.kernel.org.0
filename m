Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3337BB1908
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfIMHi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 03:38:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44907 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbfIMHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:38:57 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8D7couw022206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 03:38:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6CB2B42049E; Fri, 13 Sep 2019 03:38:49 -0400 (EDT)
Date:   Fri, 13 Sep 2019 03:38:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: New list for people to share maintainer workflows
Message-ID: <20190913073849.GA15965@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the Maintainer's Summit yesterday, we created a new mailing list:
workflows@vger.kernel.org, where various Maintainers can share their
workflows for handling patch review, collection, testing, and
submission.

We will also be discussing what requirements should be for
infrastructure that will be best suited for common use.  That is, if
we can find rough agreement on what it is needed to make kernel
development more scalable, efficient, and fun, what would we hand as a
set of requirements to a development team that could be funded by our
various sponsors to turn into reality.

Please note that this is a discussion about *requirements* not
implementation.  So for example, if one of the requirements were:

   "it should be like patchwork, in that it is fully compatible with
   e-mail review, except it should work off-line and use something
   like git as its transport layer"

it doesn't mean that patchwork would be used as its implementation layer.

Or, if there is a requirement such as,

   "it should have a web interface, and it should be easy to pull down
   patch series via a git pull, and we should be able to easily view diffs
   between the v49 and v50 version of the patch series"

... it also doesn't follow that Gerrit should be the basis of the
implentation.  (In fact, both of these requirements were expressed as
requirements at the Maintainer's Summit, and there was general
agreement that both of these would be highly desirable as
requirements.)

Of course, if the Gerrit and patchwork teams would like to participate
in the discussion, and work with a smaller working group we will be
forming to refine the requirements and to work with the LF and other
companies to find said funding to implement what these requirements
should look like, that would be excellent.  I think it's fair to say
that in their current forms, *neither* Gerrit nor patchwork completely
meets all of the needs of the kernel development community as a whole,
and as Dmitry stated in his "Reflections on Kernel Development
Process" talk, spreading out our efforts towards improving engineering
productivity may not be the best path to succeess.

Let's continue the discussion on workflows@vger.kernel.org.

Cheers,

						- Ted
