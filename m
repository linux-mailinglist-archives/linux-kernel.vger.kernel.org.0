Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8019BC9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgDBHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 03:21:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgDBHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:21:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id r16so2218158wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rmss96OJTETJ5d6k4lJWjEjgufTDQZZVOZ3mFWcInTU=;
        b=ullTaSPuuSxPAU6pdq4snMvy+5iOPZP4PxsElksZpXSvGy7jPNdd+P16TnRML4oAZ7
         2xSMsGmKBbfRgJ068PI5SdEjSnskY0lpZdMC5ccVBY4Jh802f8K09pH6L0xE7FuRy/k1
         Dk3BgyXSsc5/PdDA8Ly9I+45xP85/1LNRcXZPgA7f7HcbyFfHR1GI9OHH3T8nQRvCA92
         p5Y3TOXvgOTn50xM8saxgQuDUm7795B/TO3JHg0S5xwerNHfeobmr9V6qzwTSEmmZkKD
         74QgDaWusunmD2Dorr53zsz711/Wq3eouopiusg/gticIUMqz1eZGnC9RvbURlUQ/65m
         Wl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rmss96OJTETJ5d6k4lJWjEjgufTDQZZVOZ3mFWcInTU=;
        b=XQvhEZ2fCc2Eo6zsLnF1xdvS5D33dA5bCb8DwZ8ueeaXYZSgOoqv1hCakc6Aqxgw9l
         ZeQd0hyz4eg9+SKE7AUElR3H4JPLsg7JzPn0T/A2nEQoz4J3BF32B1mreciJno4I4MLH
         uIcepZ6hKi08exjkOEKKqHyo5zyfBM2YpXwkl+AQIZ2TUVnnxnOnSMGNd0W4w0yR60g5
         Ow+Ag98HkWg5pysrKfQNP1bAvitYgOBNHlHmnWfZzFd47GiL7QqcehFsvt/Fy/aDokoA
         /KBWU8t8kHLQwLZYJWLmfoxb5RhT4sOK+UcNBSqkbrz6lbt2lq1lSXX8pJb60Uw06K6P
         odfg==
X-Gm-Message-State: AGi0PuZgIQMMqrBimvFc+wGqmBpjg6Cx7oBDk/ZlmT/qnTjNcHv0NErN
        qRWqRpUR9oYFLcpt8uBJ+zSPoA==
X-Google-Smtp-Source: APiQypKFIbfFbHK3P7yKhCs6mZKwdUpZrLJcenhcir9vpI/T5+v8Biq0NXuCXIrwKAkdEg8KsFckDQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr2072178wmc.41.1585812057382;
        Thu, 02 Apr 2020 00:20:57 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.236.184])
        by smtp.gmail.com with ESMTPSA id v186sm5909066wme.24.2020.04.02.00.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 00:20:56 -0700 (PDT)
Subject: Re: [PATCH] selftests:mptcp: fix empty optstring
To:     Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@cn.fujitsu.com>
References: <20200402065216.23301-1-zhijianx.li@intel.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <b4a0ceed-902d-cc08-18d5-d0d8ff6269c3@tessares.net>
Date:   Thu, 2 Apr 2020 09:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402065216.23301-1-zhijianx.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 08:52, Li Zhijian wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

LGTM, thanks Li!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
