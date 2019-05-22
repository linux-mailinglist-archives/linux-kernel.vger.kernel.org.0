Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7731B2671E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfEVPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:46:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:48146 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbfEVPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:46:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 722726EC;
        Wed, 22 May 2019 15:46:00 +0000 (UTC)
Date:   Wed, 22 May 2019 09:45:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation
 warnings
Message-ID: <20190522094559.5ed8021e@lwn.net>
In-Reply-To: <39b12927-9bf9-a304-4108-8f471a204f89@darmarit.de>
References: <20190521211714.1395-1-corbet@lwn.net>
        <87d0kb7xf6.fsf@intel.com>
        <20190522071909.050bb227@coco.lan>
        <39b12927-9bf9-a304-4108-8f471a204f89@darmarit.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 15:25:36 +0200
Markus Heiser <markus.heiser@darmarit.de> wrote:

> Lets use 1.7 :
> 
> - no need for Use_SSI wrapper
> - new log should work with 1.7 [1] --> no need for kernellog.py and
>    additional imports, instead include on top of python modules ::
> 
>      from sphinx.util import logging
>      logger = logging.getLogger('kerneldoc')

I think we're going to have to drag things forward at some point in the
not-too-distant future, but I think I'd rather not do that quite yet.  The
cost of supporting older sphinx for a few releases while we warn people is
not all that high.  So I think we should:

 - Put in (a future version of) my hacks for now, plus whatever else might
   be needed to make 2.0 work right.

 - Fix the fallout with regard to out-of-toctree .rst files so that we can
   actually build again with current sphinx.

 - Update Documentation/sphinx/requirements.txt to ask for something a wee
   bit more recent than 1.4.9.

 - Add a warning when building with an older version that (say) 1.7 will
   be required as of (say) 5.5.

Does this make sense?

Thanks,

jon
