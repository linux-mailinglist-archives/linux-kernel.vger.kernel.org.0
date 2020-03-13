Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8871D183DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 01:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCMAzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 20:55:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38759 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:55:03 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so2695389pje.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KukQCqFuQ52iEK7w5avP5xTjmDq5q5jmKUrg/HJnFFA=;
        b=dBdEuzW4dXmH1//0aac/JzhJiPT/Jv6GgevIgxkCudRIIbGZ+PrZ0mGhYKid2dLDs1
         5vD8jsk43pBEcmLDcYXADKomszFsjabrjmqo0Io6kP9tuP28QeU8d/tO5Y2iMDpCB5yG
         bIOghGnbhbFbfmq+yYy8jSa35I3EEsQJnLZ4BmOq6ex+LQY5GdbVIZjN56poUwFKuNjK
         q9mFBEdgKW+lFyv9eqLAGTkQHlItXCwKO8FgRJ8itTFFhat50M2SRQ05u3buz10uU0q5
         3RtgXV7V7MtA6oiJH8Vp9IibKjnCPM8uamzKoWQi7kQi0oc8Ha4QjNP66KveXpEkFO1h
         XAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KukQCqFuQ52iEK7w5avP5xTjmDq5q5jmKUrg/HJnFFA=;
        b=IhZKpIMMkvvJwfUCkijUbHzkTi3MlClseSdXgL7uq0w/OWEEbzw3BiOG9SoPAR8/zw
         g6HYNFzaExo29l9+mNm9uv331FDn+QAFNbVe8xjUfhOkJECyQfffYUL29nyQIdnYGKE0
         ve5xuhGx2LckYfUk23uv0lQYN2dCJvgZj5KOuneBTqNBLZZKcz70Xdozuo7MrsnZ5Scs
         I0+1bW/yw8kcs19lXZlvfJWQtDfb8Ou/n2kjBZFrID+ehkYgClpjC3NVIjx+hX6YAmDm
         5WKha8F1SoeJeF2X1K52coXj0wwwN6UiCJh9EQxZVCn1j0frVLVUcRSVCez3fCE2/4I3
         x2pg==
X-Gm-Message-State: ANhLgQ2Hv2EwBrpSXcBU3qNf+Bfb1j4npyeeYSPQpMAEIub8vX1fkckH
        WviiptlfIcIpp5Rw32PrF9GiWaiI+yWDmw==
X-Google-Smtp-Source: ADFU+vtriuTwZMI7JXVCGxL/TV/G9dsfdzB1UhBFu3cGl6VpfY3w8Pf1oXpu+vw4qJPCoAfm4Pt0Jg==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr7256074pji.23.1584060900474;
        Thu, 12 Mar 2020 17:55:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p7sm10138453pjp.1.2020.03.12.17.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 17:54:59 -0700 (PDT)
Subject: Re: [PATCH for-5.7/drivers v2 1/1] null_blk: describe the usage of
 fault injection param
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200312220140.12233-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3937ffef-5b24-6b11-fac7-172a7e654374@kernel.dk>
Date:   Thu, 12 Mar 2020 18:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312220140.12233-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 4:01 PM, Dongli Zhang wrote:
> As null_blk is a very good start point to test block layer, this patch
> adds description and comments to 'timeout', 'requeue' and 'init_hctx' to
> explain how to use fault injection with null_blk.
> 
> The nvme has similar with nvme_core.fail_request in the form of comment.

Applied, thanks.

-- 
Jens Axboe

