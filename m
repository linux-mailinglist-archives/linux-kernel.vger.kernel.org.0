Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF76CF84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfGROOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:14:49 -0400
Received: from mother.openwall.net ([195.42.179.200]:32819 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727730AbfGROOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:14:49 -0400
Received: (qmail 15703 invoked from network); 18 Jul 2019 14:14:46 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 18 Jul 2019 14:14:46 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 14373AB5B3; Thu, 18 Jul 2019 16:14:40 +0200 (CEST)
Date:   Thu, 18 Jul 2019 16:14:40 +0200
From:   Solar Designer <solar@openwall.com>
To:     Will Deacon <will@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        keescook@chromium.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, tyhicks@canonical.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information about linux-distros
Message-ID: <20190718141440.GA22600@openwall.com>
References: <20190717231103.13949-1-sashal@kernel.org> <20190718094057.e4nclrw6qd2t4vw7@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718094057.e4nclrw6qd2t4vw7@willie-the-truck>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:40:58AM +0100, Will Deacon wrote:
> On Wed, Jul 17, 2019 at 07:11:03PM -0400, Sasha Levin wrote:
> > Provide more information about how to interact with the linux-distros
> > mailing list for disclosing security bugs.
> > 
> > Reference the linux-distros list policy and clarify that the reporter
> > must read and understand those policies as they differ from
> > security@kernel.org's policy.
> > 
> > Suggested-by: Solar Designer <solar@openwall.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> > 
> > Changes in v2:
> >  - Focus more on pointing to the linux-distros wiki and policies.
> >  - Remove explicit linux-distros email.
> >  - Remove various explanations of linux-distros policies.
> > 
> >  Documentation/admin-guide/security-bugs.rst | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> > index dcd6c93c7aac..380d44fd618d 100644
> > --- a/Documentation/admin-guide/security-bugs.rst
> > +++ b/Documentation/admin-guide/security-bugs.rst
> > @@ -60,16 +60,15 @@ Coordination
> >  ------------
> >  
> >  Fixes for sensitive bugs, such as those that might lead to privilege
> > -escalations, may need to be coordinated with the private
> > -<linux-distros@vs.openwall.org> mailing list so that distribution vendors
> > -are well prepared to issue a fixed kernel upon public disclosure of the
> > -upstream fix. Distros will need some time to test the proposed patch and
> > -will generally request at least a few days of embargo, and vendor update
> > -publication prefers to happen Tuesday through Thursday. When appropriate,
> > -the security team can assist with this coordination, or the reporter can
> > -include linux-distros from the start. In this case, remember to prefix
> > -the email Subject line with "[vs]" as described in the linux-distros wiki:
> > -<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
> > +escalations, may need to be coordinated with the private linux-distros mailing
> > +list so that distribution vendors are well prepared to issue a fixed kernel
> > +upon public disclosure of the upstream fix. Please read and follow the policies
> > +of linux-distros as specified in the linux-distros wiki page before reporting:
> 
> can we add a "there" at the end of this sentence, so it can't be misread as
> implying that you must follow the linux-distros policies before reporting to
> security@kernel.org ?

Sasha's patch above and the addition suggested by Will look good to me.

Thanks!

Alexander
