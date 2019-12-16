Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9395F12102D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLPQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 11:53:48 -0500
Received: from node.akkea.ca ([192.155.83.177]:42102 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfLPQxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:53:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id DE9014E2006;
        Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576515227; bh=PDG4xILM0ggz//+/yPEhO7+YPyNm+jyBiOoMiKrGSH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=InUpgdik2rw3RH9CAtDXLPzGZbi+Mj1zDS30acc3jowFAyTe3WnxZqWlBIz3jqTKP
         AQX4vJEMDoswjIXvOI5uwt+LRYip/IvOHB+5wb1gzX2ObciSlG/vu7EdXXQPwmOlv0
         A+8EBtIqugoP69y/EA4r5qWpBrUVXMydcOU6Mjuo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5XS3_Gd8CFnQ; Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 725604E2003;
        Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576515227; bh=PDG4xILM0ggz//+/yPEhO7+YPyNm+jyBiOoMiKrGSH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=InUpgdik2rw3RH9CAtDXLPzGZbi+Mj1zDS30acc3jowFAyTe3WnxZqWlBIz3jqTKP
         AQX4vJEMDoswjIXvOI5uwt+LRYip/IvOHB+5wb1gzX2ObciSlG/vu7EdXXQPwmOlv0
         A+8EBtIqugoP69y/EA4r5qWpBrUVXMydcOU6Mjuo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Dec 2019 08:53:47 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add the broadmobi BM818
In-Reply-To: <20191216122258.GC4161@sirena.org.uk>
References: <20191214235550.31257-1-angus@akkea.ca>
 <20191216122258.GC4161@sirena.org.uk>
Message-ID: <3b7f47120df1d63747788bf9de16392c@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 04:22, Mark Brown wrote:
> On Sat, Dec 14, 2019 at 03:55:48PM -0800, Angus Ainslie (Purism) wrote:
> 
>> Angus Ainslie (Purism) (2):
>>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>>   dt-bindings: sound: gtm601: add the broadmobi interface
> 
> As I said in reply to v1:
> 
> | These subject styles don't even agree with each other :( - please
> | try to be consistent with the style for the subsystem (the latter
> | one matches, the first one doesn't).

Sorry I missed fixing that. I will re-submit.

Do you have any comments on the code changes I made in v2 ?

