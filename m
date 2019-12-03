Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5910FD34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:06:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfLCMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:06:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87EC3AD10;
        Tue,  3 Dec 2019 12:06:23 +0000 (UTC)
Date:   Tue, 3 Dec 2019 13:06:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer
 implementation (reader)
Message-ID: <20191203120622.zux33do54rmjafns@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-3-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-28 02:58:34, John Ogness wrote:
> Add the reader implementation for the new ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk_ringbuffer.c | 234 ++++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h |  12 +-
>  2 files changed, 245 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 09c32e52fd40..f85762713583 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -674,3 +674,237 @@ void prb_commit(struct prb_reserved_entry *e)
>  	local_irq_restore(e->irqflags);
>  }
>  EXPORT_SYMBOL(prb_commit);
> +
> +/*
> + * Given @blk_lpos, return a pointer to the raw data from the data block
> + * and calculate the size of the data part. A NULL pointer is returned
> + * if @blk_lpos specifies values that could never be legal.
> + *
> + * This function (used by readers) performs strict validation on the lpos
> + * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
> + * triggered if an internal error is detected.
> + */
> +static char *get_data(struct prb_data_ring *data_ring,
> +		      struct prb_data_blk_lpos *blk_lpos,
> +		      unsigned long *data_size)
> +{
> +	struct prb_data_block *db;
> +
> +	if (blk_lpos->begin == INVALID_LPOS &&
> +	    blk_lpos->next == INVALID_LPOS) {
> +		/* descriptor without a data block */
> +		return NULL;
> +	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
> +		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> +		/* regular data block */
> +		if (WARN_ON_ONCE(blk_lpos->next <= blk_lpos->begin))
> +			return NULL;
> +		db = to_block(data_ring, blk_lpos->begin);
> +		*data_size = blk_lpos->next - blk_lpos->begin;
> +
> +	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
> +		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
> +		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
> +		     DATA_WRAPS(data_ring, -1UL)) &&
> +		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {

I am a bit confused. I would expect that (-1UL + 1) = 0. So the second
condition after || looks just like a special variant of the first
valid condition.

Or do I miss anything? Is there a problems with type casting?


> +		/* wrapping data block */
> +		db = to_block(data_ring, 0);
> +		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
> +
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	/* A valid data block will always be aligned to the ID size. */
> +	if (WARN_ON_ONCE(blk_lpos->begin !=
> +			 ALIGN(blk_lpos->begin, sizeof(db->id))) ||
> +	    WARN_ON_ONCE(blk_lpos->next !=
> +			 ALIGN(blk_lpos->next, sizeof(db->id)))) {
> +		return NULL;
> +	}
> +
> +	/* A valid data block will always have at least an ID. */
> +	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
> +		return NULL;
> +
> +	/* Subtract descriptor ID space from size. */
> +	*data_size -= sizeof(db->id);
> +
> +	return &db->data[0];
> +}
> +
> +/* Given @blk_lpos, copy an expected @len of data into the provided buffer. */
> +static bool copy_data(struct prb_data_ring *data_ring,
> +		      struct prb_data_blk_lpos *blk_lpos, u16 len, char *buf,
> +		      unsigned int buf_size)
> +{
> +	unsigned long data_size;
> +	char *data;
> +
> +	/* Caller might not want the data. */
> +	if (!buf || !buf_size)
> +		return true;
> +
> +	data = get_data(data_ring, blk_lpos, &data_size);
> +	if (!data)
> +		return false;
> +
> +	/* Actual cannot be less than expected. */
> +	if (WARN_ON_ONCE(data_size < len))
> +		return false;

I do not have a good feeling that the record gets lost here.

I could imagine that a writer would reserve more space than
needed in the end. Then it would want to modify desc.info.text_len
and could do a mistake.

By other words, I would expect a bug on the writer side here.
And I would try to preserve the data by calling:

pr_warn_once("Wrong data_size (%lu) for data: %.*s\n", data_size,
data_size, data);

Well, I do not resist on it. WARN_ON_ONCE() is fine as well.

> +
> +	data_size = min_t(u16, buf_size, len);
> +
> +	if (!WARN_ON_ONCE(!data_size))
> +		memcpy(&buf[0], data, data_size);
> +	return true;
> +}
> +

Otherwise it looks good to me. I wonder how the conversion
of the printk.c code will look with this API.

Best Regards,
Petr
