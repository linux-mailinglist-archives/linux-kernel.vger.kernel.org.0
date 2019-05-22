Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9386271B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfEVVfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 17:35:21 -0400
Received: from casper.infradead.org ([85.118.1.10]:59032 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfEVVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pHTjN6wqc8g/ZIVk8Anky3A0M/XSsFSNE+YjZtKGi/c=; b=T1ea4h6nm160C0WMkvM1lESEY9
        WXfv48hsTBFxwOSwjCtOO1+U/G1e53R5eWrzHofyLrtumixBqtfxzlz/vmPyMEoDWE7nb3xbEAlIj
        LfD7cOyZgAxbyzxYho2+bCd0v0q3MO9VL8R06BdwQAEV76ABsu2O9/wU/C6+D2NPmYWd/nibp5wbN
        k6fPfrFve/0vvs4B+03AcaU3pNy4uvKkDiVyQH2ZE1nbmw0lPYE6l1G5O7hC4nNzoyn3ElUeYzw3j
        +euH4npnrYlNZKB2quntJlQFqJft+TfmVbr5zvd7oC7paQdPPvTddHMtv+E4c7ytp3Hslw5qCN0Y4
        BolVrh3A==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTYtJ-0006n4-5u; Wed, 22 May 2019 21:35:17 +0000
Date:   Wed, 22 May 2019 18:35:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sphinx-pre-install: make it handle Sphinx
 versions
Message-ID: <20190522183511.1c4a3317@coco.lan>
In-Reply-To: <20190522143506.34049678@lwn.net>
References: <a741574b7081c162d200bdead35302ccac6fd116.1558545958.git.mchehab+samsung@kernel.org>
        <20190522143506.34049678@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 22 May 2019 14:35:06 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 22 May 2019 13:28:34 -0400
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > As we want to switch to a newer Sphinx version in the future,
> > add some version detected logic, checking if the current
> > version meets the requirement and suggesting upgrade it the
> > version is supported but too old.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> I've applied this in the branch with my other fixes (coming soon to a
> mailing list near you), thanks.  I do think we eventually want to emit a
> warning during a normal docs build as well, and to raise the recommended
> version, but one step at a time...

The enclosed patch should do the work. It will probably be too verbose, but
it should be easy to add a "--silent" parameter to the script, making it
only display a message with the version warning.


Thanks,
Mauro

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e889e7cb8511..9c80105995e7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -70,6 +70,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	$(abspath $(BUILDDIR)/$3/$4)
 
 htmldocs:
+	@./scripts/sphinx-pre-install
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 linkcheckdocs:


