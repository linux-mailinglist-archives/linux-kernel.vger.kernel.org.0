Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE639E6B77
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 04:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfJ1D3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 23:29:51 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45181 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1D3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:29:51 -0400
Received: by mail-pf1-f176.google.com with SMTP id c7so4717970pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+5aiWeXstBz8ObJ+bhMpKSFQ8KKTxMpPVZxxthb9HJk=;
        b=upKTRMSgzY1qcOKKO7XaF4D+/fcJSOPUFRMbjd44byQPY7nx7NKYSVck0yb4v1zr0g
         tCmjEjVM+gAVrvellGdMsq5mo0DBcNxuRs4SkW+lv+yrNcsOs73W16TeiJzNUYEjfhUq
         e4Mr5074QZL6VLme6sRzHJcnwWkX5fdF8aSabxd0MjU68nA+8vV4qRvWKv8g9tL69MDW
         xXmc+W+FUJrDZnnX/gGajOD9KmQ2IMCkaBWARSPv0jCcYTMwl9KmgPZFdOfGocBCDxUd
         m2vf+4snbnbOGaHudIELYsLu0q5QCK/C0Klk1/G3Q2gT1jdSpKbOQ9uvA3DyiJHkbcNs
         QZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5aiWeXstBz8ObJ+bhMpKSFQ8KKTxMpPVZxxthb9HJk=;
        b=UeMQE3CMUdDhDLJLAOSVEEPzAXU2JX4JcRZdG3IlVPnlpj5BdmnEvUaJl+BoYjlUtH
         Cl5LcZsjWOIfiAR82WiGbAs5tpWxPfwZ3FEG9eEvoqWKr5I4Wqqi7x4toChhkMZp0S80
         0LzJ+NwJ9Actwf4BnTqmNVV5z7r3hyMuNwB1C1yGc1XYtF9qBjMsKIKtzrZCv8nUs0bw
         ifH+vY6d6/HRlpS4qJCqfK3RkjlGDHBmG8q6iVSAA7iX18l6+62rsCU/fq1prsy93ibx
         sISpQaC6RojF97cA/Cy0JLp6Fg8TbEABqXw0RGUl0gnb8E+6T+4sYqeprrGcflW4BIJr
         smvw==
X-Gm-Message-State: APjAAAXPXYYZ02eJS9EP65VEU/nr7KbEiNCkFjf1QUbvEItvstk+/mAw
        IMkZsROe/pXVPuQWXT3xCyCSkgnfNVDEhA==
X-Google-Smtp-Source: APXvYqzyLrFdi71UNo4Yn9fhDhIiSFob12dE5++q4nV0gnj7wCd4j0bOeoI+VS3dsQ/wBH+ScRb/wQ==
X-Received: by 2002:a63:2f45:: with SMTP id v66mr18005385pgv.448.1572233388895;
        Sun, 27 Oct 2019 20:29:48 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q3sm11567489pgj.54.2019.10.27.20.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 20:29:48 -0700 (PDT)
Subject: Re: [PATCH][for-linus] io_uring: Fix leaked shadow_req
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <47835fb780667714ba2d21e9a00fe69bc9bbef47.1572203348.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b46e7b1-0719-d88f-175f-c9fdee224b38@kernel.dk>
Date:   Sun, 27 Oct 2019 21:29:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <47835fb780667714ba2d21e9a00fe69bc9bbef47.1572203348.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 1:10 PM, Pavel Begunkov wrote:
> io_queue_link_head() owns shadow_req after taking it as an argument.
> By not freeing it in case of an error, it can leak the request along
> with taken ctx->refs.

Thakns, applied.

-- 
Jens Axboe

