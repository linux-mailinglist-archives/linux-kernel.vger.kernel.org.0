Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3525139B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 22:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAMVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 16:03:50 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36906 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:03:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so4823285pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ij7lapa7eHtDYB0tYmlUrJfm8Bkbbx3GGnUvbTNYcg4=;
        b=MOBsfrZr4ml2h1uRLM7oiJaVCfJul1XJfuQmEDaa1zRIeXMINsw95pVP3MgY6NfeqZ
         udmvCzwWYpOQt0G3mRzebBoyfnJK9T3L05PgRXlKlwU31G6nq4XjSCRToXeCY2w82z62
         4FUiVPW0dgwNIfW9lJT//0zvmvUTECToJz9lJwPSKavZ57rVfm+YySPDEIgjsPLoaXCz
         m1XnZxPznEc0UkHXILfB5ICxQqkG86hi0iFy/4ZiGrxLVb5ZM98tjcpKtaE5ntj0q6FG
         EpgzT06idNNI5lQAiyliXHOGP1qVIj7RrqT1Qu+IsgmX9SniQTSk2bZsLNGw0HNg/b7N
         vbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ij7lapa7eHtDYB0tYmlUrJfm8Bkbbx3GGnUvbTNYcg4=;
        b=WspDzyYNIp3G1Wo6o5fjffO7J91R8uw4IdY7cGqpMwe9TiZOkRE3+0uVIqQmynOekX
         Ce8uCx/LwvRfp8D1JaQfJoZNoI09Eh/xkiXnK6xi1mmc1FuKgas6mZ2ATmC3qKgA8wjU
         WN99yk60Vbxzf6o5Sd3NCPKoMhroy1axElj5KmJLYyCkJ0mQ/3XkgZurFECtPAVQ5p3Z
         XE3doHBExsnjQfIr0ddbZj7uBIeCGIa9+L2KhICFbShy0ihKBahirlb7HkImNX7YFkHg
         a+tT4Fok6irsl731/Xyp/DsIAIWuEgXI2GpuVM5C6WnQiKZk8ByBT9MeZTavRPQS5/i5
         sTTg==
X-Gm-Message-State: APjAAAWMRKF4GQMq3/704XkSqiDhC9kosx8JlfFtGqIqHaih9zGuzkGt
        uNm05wNvcCTgB0y4Iwz2c8SwOg==
X-Google-Smtp-Source: APXvYqwrPdrIkffcZNWEQMAoMthTZ0uX/c/Um/uGK2FoJ8AFVNCKy82SuJ3lyZ0bGaLHhX9yF3Mk3g==
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr24866382pjr.17.1578949429676;
        Mon, 13 Jan 2020 13:03:49 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l66sm14746332pga.30.2020.01.13.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:03:48 -0800 (PST)
Date:   Mon, 13 Jan 2020 13:03:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: use is_vm_hugetlb_page() to check whether to
 follow huge
In-Reply-To: <20200113070322.26627-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001131303310.127816@chino.kir.corp.google.com>
References: <20200113070322.26627-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Wei Yang wrote:

> No functional change, just leverage the helper function to improve
> readability as others.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: David Rientjes <rientjes@google.com>
