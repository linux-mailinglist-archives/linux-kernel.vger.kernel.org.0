Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF36335D7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFENHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 09:07:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34547 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfFENHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:07:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so9126651pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wOlyBFObbo8NjdwW/6yyuIHGU1UFK5s5OLlA3iBoq+w=;
        b=FHVBZSYxmRtSJYlqQE0H/b8ZtWCu695UJZ+WO7ngmounpNDd6iuwZjKE421R2ZccPO
         GJZzw1FsL1ZFgnaCVULcC95mrP/8jCJmXao2OHGeJjzAcQa0/VRFu4veT8pbsvd1+R0I
         nAA59AXZVzBTFCNSTeXN07vPh9igCwIq1Bw/AqouS9PsTEdmGdXk0f1pd+wtnWxlIgO8
         ReT7UuJZpNn9QaTMp0IA7ixS7XXrChbH3t0IJUJS1ceTCDqlzwYrYgg7zHeAtA6SKyZ6
         Qe2f62gMzZ2YvjwcITQ6RHJsNNByTelmkp4bV/IHHvokLcAXtkVHL9dsgQ1OcNJ8wf+9
         hKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wOlyBFObbo8NjdwW/6yyuIHGU1UFK5s5OLlA3iBoq+w=;
        b=o6xVuoxw3MsYA97JAPCq7TwmLzIVMkcg/b5OOO+KcGs5btwfzdCLlhjdORZzK99PC9
         TSR4EM2epZa8VSAxpD8hPezl0GzX8SfHfiX/c2JGXZsL7g1S8sFM/j7mjymbjlOftl3n
         DA4t6VDLckGE2vifFI7+XFAJAp1CD2FAGd03dIjtL3xjUBbQ6DWCTjzWax4aSoUp5Hma
         d4aRZVgFEV+rOHr9jgspAJnWQ5PX1W12SrRGZv04db63yYJcX2IAkGfzF6LUBkcck08p
         d4npLdX+E33zrdJzN2UMcNif6Jj763gLzEs8NQxt2R21SQOH/sGv+1dL7w/2zlnbHydl
         kLhg==
X-Gm-Message-State: APjAAAXvahC0XdyeCxi44cn0ha/ixTdzKPgm3zUjhTDcVTPBPdrF50Qs
        aztPFJ0fVx2bu4k3snDcFEigbjyC
X-Google-Smtp-Source: APXvYqzZ7bEahJmYv3MKynQwr6920gIAVIlvDpIe1bC9ArADTolL3SDQfZvrSpqhIJfypgBQSAUCrw==
X-Received: by 2002:a62:65c7:: with SMTP id z190mr46027677pfb.73.1559740057712;
        Wed, 05 Jun 2019 06:07:37 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([2401:4900:2716:aaa4:847a:64de:b0a1:1485])
        by smtp.gmail.com with ESMTPSA id d20sm18942088pjs.24.2019.06.05.06.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:07:37 -0700 (PDT)
Date:   Wed, 5 Jun 2019 18:37:28 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, rientjes@google.com
Cc:     khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605130727.GA25529@bharath12345-Inspiron-5559>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
 <20190605070312.GB15685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605070312.GB15685@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Not replying inline as my mail is bouncing back]

This patch is based on reading the code rather than a kernel crash. My
thought process was that if an invalid node id was passed to
__alloc_pages_node, it would be better to add a VM_WARN_ON and fail the
allocation rather than crashing the kernel. 
I feel it would be better to fail the allocation early in the hot path
if an invalid node id is passed. This is irrespective of whether the
VM_[BUG|WARN]_*s are enabled or not. I do not see any checks in the hot
path for the node id, which in turn may cause NODE_DATA(nid) to fail to
get the pglist_data pointer for the node id. 
We can optimise the branch by wrapping it around in unlikely(), if
performance is the issue?
What are your thoughts on this? 

Thank you 
Bharath
