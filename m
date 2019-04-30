Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4771035E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfD3Xit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 19:38:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44293 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfD3Xit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 19:38:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 54502256B7;
        Tue, 30 Apr 2019 19:38:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2019 19:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=8TVoOxfmq1R3Lbx6jbxXVrEWbN6MuryN18FbCzDou9s=; b=Zai/gP+vVuQx
        WTyTP6dJRquBVk3yrK4Z4VAoO+4JROrrXcz8PB/ZYGDL9aMWSuG/Dx0Ry4/d3n7E
        hoyMoXluZGPUjXrp2Ji/9hhjjZB9HN2eZPPmlj6vymgxs8RHlPW+NrUIP3aPdOt3
        HLcpEyr0Qd3xKc9wMoBA9xx3u7oJymtELL94X71HpxkFsGXTC7DOjOiIyLUq4NZj
        t+28eo8ppFjbecnwTavfrK4chWnPMNKjc1F7vnEZ2VWdu7LGJnAAr+tlmM4kjWm4
        fRx34LvqaCgE3mClUFQf0gZkSupux1IpkXZqO6FAH0pPo0sjPdoOTuTpGvPgUIDY
        /WWQbQmSFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=8TVoOxfmq1R3Lbx6jbxXVrEWbN6Mu
        ryN18FbCzDou9s=; b=Rjo0B2mSm4lnRgEn36mgC64DVZYYMpGZal8CRkef0ade8
        ky1LpNg0iSz6wLU+hQnbauWMSrAAGs8NuXqXJXaqaZBpNTS5UUz3UVraRxUC3p0T
        xwce8ImAjofdHTRkhBdisl2DtEInRvMwmvDxT+M8EA4eRAaTfX77PdBUe8KwvvWf
        GjPiHFo2evgOAPPawNEUW5/Kk5su5B3HYR9BY7Q3rpS1PYCYvVh2vZvZtek45cm7
        3ux7xhAzkuDDTSgQBAbIeqG5h5eMfSGNXWb9NnWGpmyIJoWn0QpXPhimGmFVdCVx
        VLjG1SGsJmwUWCBcUf6hqqBlLVdHHcNdZyaTMp9Yw==
X-ME-Sender: <xms:hdzIXAj2OWPutOJPj5mpHZX_ZmcpL5_QNwUwWCMSCH5VrpM9RegrDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfggtgguofgfsehttdertdforedv
    necuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosghinh
    drtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:hdzIXK5J3TwURYj2mo3UIBjd4pQUWWaSU4gPhY9jQ49VQgJzoc0GDQ>
    <xmx:hdzIXNPkMHygKF-mPQpM0c6L18GEqGkTsnN_y5Ilk4udpy6gTefK6Q>
    <xmx:hdzIXBdpvAT4ROL8m0hwnuJUKmvMFbyBwxiWTDYL3a5EgevykuNJ-w>
    <xmx:htzIXPh7y2DOjMqkVivRCyx96tVcKmFr7p2uJB9G2v-coigTxQA-gQ>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3788FE442F;
        Tue, 30 Apr 2019 19:38:42 -0400 (EDT)
Date:   Wed, 1 May 2019 09:38:03 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kobject_init_and_add() confusion
Message-ID: <20190430233803.GB10777@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like I've created a bit of confusion trying to fix memleaks in
calls to kobject_init_and_add().  Its spread over various patches and
mailing lists so I'm starting a new thread and CC'ing anyone that
commented on one of those patches.

If there is a better way to go about this discussion please do tell me.

The problem
-----------

Calls to kobject_init_and_add() are leaking memory throughout the kernel
because of how the error paths are handled.

The solution
------------

Write the error path code correctly.

Example
-------

We have samples/kobject/kobject-example.c but it uses
kobject_create_and_add().  I thought of adding another example file here
but could not think of how to do it off the top of my head without being
super contrived.  Can add this to the TODO list if it will help.

Here is an attempted canonical usage of kobject_init_and_add() typical
of the code that currently is getting it wrong.  This is the second time
I've written this and the first time it was wrong even after review (you
know who you are, you are definitely buying the next round of drinks :)


Assumes we have an object in memory already that has the kobject
embedded in it. Variable 'kobj' below would typically be &ptr->kobj


	void fn(void)
	{
	        int ret;

	        ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
	        if (ret) {
			/*
			 * This means kobject_init() has succeeded
			 * but kobject_add() failed.
			 */
			goto err_put;
		}

	        ret = some_init_fn();
	        if (ret) {
			/*
			 * We need to wind back kobject_add() AND kobject_put().
			 * kobject_add() incremented the refcount in
			 * kobj->parent, that needs to be decremented THEN we need
			 * the call to kobject_put() to decrement the refcount of kobj.
			 */
			goto err_del;
		}

	        ret = some_other_init_fn();
	        if (ret)
	                goto other_err;

	        kobject_uevent(kobj, KOBJ_ADD);
	        return 0;

	other_err:
	        other_clean_up_fn();
	err_del:
	        kobject_del(kobj);
	err_put:
		kobject_put(kobj);

	        return ret;
	}


Have I got this correct?

TODO
----

- Fix all the callsites to kobject_init_and_add()
- Further clarify the function docstring for kobject_init_and_add() [perhaps]
- Add a section to Documentation/kobject.txt [optional]
- Add a sample usage file under samples/kobject [optional]


Thanks,
Tobin.
