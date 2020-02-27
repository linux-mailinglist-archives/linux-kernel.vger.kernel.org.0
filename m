Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE9171365
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgB0IzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 03:55:22 -0500
Received: from smtp2.goneo.de ([85.220.129.33]:50158 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgB0IzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:55:21 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 03:55:20 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 6FD2023FBB3;
        Thu, 27 Feb 2020 09:47:47 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.775
X-Spam-Level: 
X-Spam-Status: No, score=-2.775 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.125, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AGR4Fuwz1hdT; Thu, 27 Feb 2020 09:47:46 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-091-096-139-105.ewe-ip-backbone.de [91.96.139.105])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 7B2D723F4C9;
        Thu, 27 Feb 2020 09:47:45 +0100 (CET)
Subject: Re: [Linux-kernel-mentees] [PATCH] doc: Convert to checklist.txt to
 checklist.rst
To:     Amol Grover <frextrite@gmail.com>,
        amanharitsh123 <amanharitsh123@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200225183916.4555-1-amanharitsh123@gmail.com>
 <20200227083010.GB5241@workstation-portable>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <c844ac77-4841-3454-dc92-5af0c9800a22@darmarit.de>
Date:   Thu, 27 Feb 2020 09:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227083010.GB5241@workstation-portable>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.02.20 um 09:30 schrieb Amol Grover:

>> diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.rst
>> similarity index 99%
>> rename from Documentation/RCU/checklist.txt
>> rename to Documentation/RCU/checklist.rst
>> index e98ff261a438..49bf7862c950 100644
>> --- a/Documentation/RCU/checklist.txt
>> +++ b/Documentation/RCU/checklist.rst
>> @@ -1,5 +1,7 @@
>> -Review Checklist for RCU Patches
>> +.. checklist doc:
> 2. The document identifier must always start with an underscore and
> should not contain white spaces, something like:
> .. _checklist_doc:
> should work.
> 

Sphinx supports whitespaces in anchor names, see by example [1]

[1] https://asciimoo.github.io/searx/dev/reST.html#anchors-links

  -- Markus --
