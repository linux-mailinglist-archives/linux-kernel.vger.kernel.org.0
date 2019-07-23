Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D032570F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 04:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfGWCRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 22:17:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44016 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfGWCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:17:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so18562597pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t/xh5wSawJ8Oerj64U5J6wYsxSNAL6y2p2sEZVqs5go=;
        b=IfZRMZTsh/dfz0ij8J6Xk1sdYcSgAGVi+h9p9Kwy9LLw6csjKuZBs4uYH7auR1JFq3
         sQ9tY4RVJMkg1Kzg6iiZ2PazBWVr7XxwEEcHF+cdqYP0tMAeEvhlMyl37sDbiBVsPtjE
         f7d+hdp2lvNN+0yi+Z7ucZ5TlPNRabobgBKKE7cNw+OhyAS9WjAXW97jpttU6SG6i0C+
         x9jjx4WNa5g+xRyYlSaJttbBhMoUvTGKcNpRT8w9MayqoiB8mp1hBrHJIU2uTYbMe7bg
         rYBcZOZugmQYlRFWNCDGBbD6yrfzKTXlOhsGWb/nhMBJR5SMKij1TJGMilwdzRN1LonM
         Etug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/xh5wSawJ8Oerj64U5J6wYsxSNAL6y2p2sEZVqs5go=;
        b=tmMfWMKfqbH8ubxA81aJaSBDJjyZMJciu0WK/jHx+wX14M1CweaJKkkL3dX2UOpkRp
         aaUPMYALmuEbvUnvjbgzrFSV0CyZQ8vO+VxxcjGl4YAE8SUWAsHGisTbE9G9wktyDto8
         oCfaGIyMuiFnDz7mObgHPoUbxJO2po6z4TQINuAYibcDQoWfDGY6AZ+ytS4am0AMtMRY
         xGZtEgxzUNdFwt8HcnDUYqCZJkj4BElkRwaulUaSYzNjIHpB+PBPQkSMHr+ipdSyRRjm
         I0Bf05hWi5EvdYlY+wEVzoPUmnXzpW43GXhgAkbZl+OGojXQ7E4M/iCM/uqjzPlHgSk/
         apzQ==
X-Gm-Message-State: APjAAAW4TeoR8PsqE/TMEeq4+9c/nnPQEMQk9wQUDnH0Qvx7/rQeeFx4
        HWS7kHmHPUac63F+Tm56wEs=
X-Google-Smtp-Source: APXvYqxzOqKV9kQ6Gsm9HpHqCzeUQSF9Zh0C+EW4GeY0aM73DCnJ0bnJnlg4L3ArDGLMaSKHlxhPaQ==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr3286688pfd.19.1563848273863;
        Mon, 22 Jul 2019 19:17:53 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u23sm41544350pfn.140.2019.07.22.19.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:17:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove blk_mq_sched_started_request function
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.com
References: <20190723021439.8419-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <864e671d-06ba-9689-9caa-8435cde1c860@kernel.dk>
Date:   Mon, 22 Jul 2019 20:17:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723021439.8419-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 8:14 PM, Marcos Paulo de Souza wrote:
> While inspecting the queue_rq calling sites, I verified that
> blk_mq_start_request calls blk_mq_sched_started_request, and this function
> checks if the elevator of the current request implements the started_request,
> but currently none of the available IO schedulers do.
> 
> So, let's remove blk_mq_sched_started_request along with started_request, which
> is member of the elevator_mq_ops struct.

Looks fine to me as it's unused, but please fold the two patches. Makes no
sense to split that into two separate patches.

-- 
Jens Axboe

