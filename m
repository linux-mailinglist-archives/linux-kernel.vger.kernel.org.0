Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB4F7494
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKNOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 08:14:31 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38828 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:14:31 -0500
Received: by mail-wm1-f48.google.com with SMTP id z19so13158888wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSSh3GLhg1vsDC2+/ekTGoEZx+xBL7fSSkyIjDBus0Y=;
        b=Hbv7vTAJaj3aLmwp1G2ep546uZEGDBhi+No53kbAa6wWPB2FUuSzQQNt4SsHuEN8GQ
         HOkbiVLgICe1ia9awIe0L/ZyaHt8V5FNGkmWEjYcJ3MwIay/64IGOcm/mM1XU2XSBZHg
         +NC8P6rEpo8CNdNh8I7JHCXqgbNRUvoRrrLk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSSh3GLhg1vsDC2+/ekTGoEZx+xBL7fSSkyIjDBus0Y=;
        b=oo7wj8bPPt0KLg81bN6x2inBvBdWQokONbyBkSROPctWkkbMa3WzOw8/d4gewUWWGQ
         5RyrEYBVAxXrm74oP0ARDUBjPoJLFp1kbRPlxhYSFp8MGJbD0zCoc5ZYhXyl+esKBZeE
         lvVDE7SFCcRinvrUfnb2VeKqK6BcTE2d8/qTWSCeE+IZwq3pVMgdofBOviRXq7VW5hkU
         Og5HwHuSGQd0V/CW2SZfDAbhjrKdRE2IFlmk3vauNPnyPZemSEbJ0dEScBJqO3Vj7ked
         wLOQS7OWnHbsKTKGyCxiED4V0usHGtYN75VgVCh8j37Ch3js6DnRNogtAwlQTcIevpD/
         yNdA==
X-Gm-Message-State: APjAAAV4WPtmOnvhOEG5cfgEtW7s8n4/j3tCt9yAnpeSlGCLYzaCM3QK
        RQzJn28Hq/goVoiBS+WGv/Bjow==
X-Google-Smtp-Source: APXvYqyvhczbf2LwFCvdR3MOfU8SLKVDbuWW3StMeBDBW7wyn9GfgKvdjUBLmTzPLz1EDYVikGjX4g==
X-Received: by 2002:a1c:60d7:: with SMTP id u206mr21398439wmb.101.1573478068839;
        Mon, 11 Nov 2019 05:14:28 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id u13sm6150007wmm.45.2019.11.11.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:14:28 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:14:27 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111131427.GB891635@chrisdown.name>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191111130516.GA891635@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Ah, I just saw this in my local checkout and thought it was from my 
>changes, until I saw it's also on clean mmots checkout. Thanks for the 
>fixup!

Also, does this mean we should change callers that may pass through 
zone_idx=MAX_NR_ZONES to become MAX_NR_ZONES-1 in a separate commit, then 
remove this interim fixup? I'm worried otherwise we might paper over real 
issues in future.
