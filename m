Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67711756E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 10:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCBJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 04:23:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40327 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:23:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so4178685pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X50f3KltXHYHA3hHiuSfi+hu3pg0WDIwQipk7QuSG+4=;
        b=aYnyAQOr9VuGffJkqNSsTkS7Qnfhqmk/Qy4UVEYJIwqHwVBpNQYLwR/5BrQVsvWZ45
         4HivLJnIcEKz/4ok5iRRuRf/P25hVn+iLj7EEZR036jusbBNXOPuPoSxaPnt+cp74ukS
         tR8P2q9Ea48odYx0/axNp+nAOk0wPQUtrL3WCvtW2HlUYW7hN8Ujd8LG6eTSPEbnGq1D
         OgWwUiXn/cojeQyODLM1AM9cvEe+ZE4c84OEYCsvvg7HeUyBsM6ZdDtZcHr6/Wcq8xI9
         D83fhow5waF3bE/RjePjD5GDrvagf/4nXJOsT/GIjhC/+I5b5LGsiwupvJdoI1AFPPcH
         oVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X50f3KltXHYHA3hHiuSfi+hu3pg0WDIwQipk7QuSG+4=;
        b=SplvaTnXME6TLNPI59PX1NtjA7a6v4/mVX3v71JBDg5m5pva/RpJqHTE3syNzcGjOc
         pkHJ4LRpcXoWV4DiQP97JY9xoeQWab2Kt/iObpyW05Y0ha0BmsEWwOlK8cwLM9cQeIDI
         0f+Y7N0Ue2DDaFu1AznWenwPGBJvOCPf+mdZy+0fvZoJAcQAqAOvScK6IFGeWwSXjZdn
         loqgOLxluiEGRCB65OSjljVE7rvaLseqQ1Asm0pyWYzGxCI0dUlpTp7h9UODTZTzJx0C
         FwwEP2Q4mwsFWcXpS2vTX1T+zI8yUvLr3Ufy9DOZhJxLI1qDPbudA7o82nK8KmhPEg0o
         mQBA==
X-Gm-Message-State: ANhLgQ1WY22Moyh7PmoZchLFATwMtdbcG/btsToYfLh5APXlUUPav58Q
        9dfYiMpH367Qaj9K1MV/30g=
X-Google-Smtp-Source: ADFU+vvW98z93Yp+1Dy8C/iQY3xi+XM1cHEXPmj/VK4MkhXgtgex+cQP4PWoRYXQausGSGTCX5UPrA==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr5771812ple.302.1583140984048;
        Mon, 02 Mar 2020 01:23:04 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id a36sm19887909pga.32.2020.03.02.01.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 01:23:03 -0800 (PST)
Date:   Mon, 2 Mar 2020 17:23:01 +0800
From:   sunjunyong <sunjy516@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: fix a double abort case with
 fw_load_sysfs_fallback
Message-ID: <20200302092301.GA25139@mi-OptiPlex-7050>
References: <1582876593-27926-1-git-send-email-sunjunyong@xiaomi.com>
 <20200228130735.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228130735.GA11244@42.do-not-panic.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis:

This issue is caused by concurrent situation like below:
when thread 1# wait firmware loading, thread 2# may write -1 to abort loading and wakeup thread 1# before it timeout.
so wait_for_completion_killable_timeout of thread 1# would return remaining time which is != 0 with fw_st->status FW_STATUS_ABORTED.
And the results would be converted into err -ENOENT in __fw_state_wait_common and transfered to fw_load_sysfs_fallback in thread 1#. 
The -ENOENT means firmware status is already at ABORTED, so fw_load_sysfs_fallback no need to get mutex to abort again.
BTW,the double abort issue would not cause kernel panic but slow down it sometimes.
-----------------------------
thread 1#,wait for loading
fw_load_sysfs_fallback
 ->fw_sysfs_wait_timeout
    ->__fw_state_wait_common
       ->wait_for_completion_killable_timeout

in __fw_state_wait_common,
...
93	ret = wait_for_completion_killable_timeout(&fw_st->completion, timeout);
94	if (ret != 0 && fw_st->status == FW_STATUS_ABORTED)
95		return -ENOENT;
96	if (!ret)
97		return -ETIMEDOUT;
98
99	return ret < 0 ? ret : 0;
-----------------------------
thread 2#, write -1 to abort loading
firmware_loading_store
 ->fw_load_abort
   ->__fw_load_abort
     ->fw_state_aborted
       ->__fw_state_set
         ->complete_all 

in __fw_state_set,
...
111         if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
112                 complete_all(&fw_st->completion);
...
-----------------------------
On Fri, Feb 28, 2020 at 01:07:35PM +0000, Luis Chamberlain wrote:
> On Fri, Feb 28, 2020 at 03:56:33PM +0800, Junyong Sun wrote:
> > fw_sysfs_wait_timeout may return err with -ENOENT
> > at fw_load_sysfs_fallback and firmware is already
> > in abort status, no need to abort again, so skip it.
> 
> What exactly is caused by this issue though? Are you seeing
> a kernel panic, some extra messages in the kernel log? This
> informationw ould be useful for the kernel commit log.
> 
> > Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> > ---
> >  drivers/base/firmware_loader/fallback.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 8704e1b..1e9c96e 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -525,7 +525,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
> >  	}
> >  
> >  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> > -	if (retval < 0) {
> > +	if (retval < 0 && retval != -ENOENT) {
> >  		mutex_lock(&fw_lock);
> >  		fw_load_abort(fw_sysfs);
> >  		mutex_unlock(&fw_lock);
> > -- 
> > 2.7.4
> > 
