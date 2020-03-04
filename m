Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938EA1794EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbgCDQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 11:21:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34945 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:21:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id v15so1792702qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dA2hYD+OudMyLEYw9vGPZKppB+9NldT/3jWoHjIzdlg=;
        b=eamRAbG0xhZrCMRXKsXIG0E8aFb8uc1gEQfEi/UAcZdwr3itU9ulHanDYM8rwKFiCj
         DAvEgoTXE9h3DqPk9xZKKjj390D8KRXaTDxGFsSlAXU8HS2VDwFXz7f+SwvL9OkaURet
         HGYi0qvzLxg+mzMb5BlVEyZHs/pEccvjB0+nmd+HI2mhqheNOMfS0dSXfF2aTJ5sybHf
         H3bG6GUp2sQobHfUtd5w926RrDUSX6qHJi7ZIqH1yuUw3qVAFdC7VnCYez/1HeQrxkkQ
         SWWkz5JoP+6kHZZ0wXqz7C5et0IhHr/vilu3kGITpHEWJi+uVBjjwcm8bR3bXaErRK+a
         EgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dA2hYD+OudMyLEYw9vGPZKppB+9NldT/3jWoHjIzdlg=;
        b=rXgI+Eff3Jq+YK98sv9B4H2xTcJOzKOPzMX5zRaQiMd9qnGWzf24ZLaKKbfucYrIDr
         PgsM0TvL0DZDFwTCX937v08X4W8v6E2HrMIVMdo9uokColo9UIF5Jae4ZI9JdQNHSNUQ
         U3hU8Bulp/RVHNeBU4ruQ5Hbv2SVfWZRVB3wNKbO1MhFTqizxIfiWrvsiiUQDfvo8MBr
         4c2iCLsItjPMwzHu2U2GeUUlbI2VNbluEJuTJaUKlDnCTiSsI4dMwEi8MEye4bm8Un3E
         xwvpFdgWEOmISYXaghSzQhOqqE8TCDl2zb9y6l7+b/YVB/p3QGSgmej9of0mgZ7aINgq
         9j5Q==
X-Gm-Message-State: ANhLgQ3KO3yl7SpIftcZNekkOUeyYykRS5bRieM6oXv21WHi+kY1Lj3I
        33Fg4fssx98DuyIyi4sv1gk=
X-Google-Smtp-Source: ADFU+vvhJ7nC607fUEZnIeQ3XKKD0XsCUc0dD50xdDho/SyOSc8B/zFdXKlt884z9ucWNtqwzUf6lA==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr3124541qtr.198.1583338862563;
        Wed, 04 Mar 2020 08:21:02 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id 4sm5798235qkl.79.2020.03.04.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:21:01 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:21:00 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yu Chen <chen.yu@easystack.cn>
Cc:     linux-kernel@vger.kernel.org, 33988979@163.com
Subject: Re: [PATCH] workqueue: Make workqueue_init*() return void
Message-ID: <20200304162100.GE189690@mtj.thefacebook.com>
References: <20200223072852.3954-1-chen.yu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223072852.3954-1-chen.yu@easystack.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 03:28:52PM +0800, Yu Chen wrote:
> The return values of workqueue_init() and workqueue_early_int() are 
> always 0, and there is no usage of their return value.  So just make 
> them return void.
> 
> Signed-off-by: Yu Chen <chen.yu@easystack.cn>

Applied to wq/for-5.7.

Thanks.

-- 
tejun
