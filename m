Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15368188993
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgCQP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:58:59 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51771 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:58:59 -0400
Received: by mail-wm1-f53.google.com with SMTP id a132so22045665wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYhH5q4WEl1FEeszV9WnzdrzRhQsi77Q0fjkKyiS8K8=;
        b=s/Uaqd36AjVrV8nBsVkpbGsBDfXcdWzFUojhtrw1D7euEE1mO9n2yoRC7CnQNJlmfd
         pb69r8M/E8qGTF4FEm/VWEk6ysxlNTFL0ZdMo6tMSbshc69mbDN0zGlfYy2vSdDyOwVk
         piGN59Dqm80KyJurDTs8d8FcJlUyutJANScB5m9RJpP61uS6UuREhVjNNskJQJ1GSWuO
         wUwJG/ks7f4SOAR9hIKVkXpeVj0XOjQO2vHWeq1m2fEg0iiMfUYVVRK0M1B3WZZX7ZcW
         4HGy9qsAAV9X3Oyx+jtipXTBdsJt59jaHvIGecAmTNt+KHe1g4v2RQmsHcsDGiPSWuyn
         2DiA==
X-Gm-Message-State: ANhLgQ0ceDfex/NPjlrcD0L+QiFzkc4+CvAZU/dPRD3s9PbzT1rwC3Uk
        z+6NFK82Y1eRdG3sENx1snA=
X-Google-Smtp-Source: ADFU+vtXMrtZwl2B9c9BXLxh92KX3GuxYzjcrVUmZMxyVywjJwgO8Q2gOZ17aY6Ccxd+xD91MfQb7w==
X-Received: by 2002:a05:600c:2250:: with SMTP id a16mr5756585wmm.57.1584460737542;
        Tue, 17 Mar 2020 08:58:57 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id w7sm5368320wrr.60.2020.03.17.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:58:56 -0700 (PDT)
Date:   Tue, 17 Mar 2020 16:58:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200317155855.GS26018@dhcp22.suse.cz>
References: <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
 <20200313205941.GA78185@google.com>
 <20200316092052.GD11482@dhcp22.suse.cz>
 <20200317014340.GA73302@google.com>
 <20200317071239.GB26018@dhcp22.suse.cz>
 <20200317150055.GC73302@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317150055.GC73302@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 08:00:55, Minchan Kim wrote:
> On Tue, Mar 17, 2020 at 08:12:39AM +0100, Michal Hocko wrote:
[...]
> > Just to make it clear, are you really suggesting to special case
> > page_check_references for madvise path?
> > 
> 
> No, (page_mapcount() >  1) checks *effectively* fixes the performance
> bug as well as vulnerability issue.

Ahh, ok then we are on the same page. You were replying to the part
where I have pointed out that you can control aging by these calls
and your response suggested that this is somehow undesirable behavior or
even a bug.

-- 
Michal Hocko
SUSE Labs
