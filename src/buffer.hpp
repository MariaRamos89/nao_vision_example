#ifndef BUFFER_HPP
#define BUFFER_HPP

#include "includes.ihh"

/**
 * @brief buffer to save state or actions
 * @class buffer
 * @date 17.04.2018
 */
template <class data_type>
class buffer
{
public:
    /// @brief constructor
    buffer();

    /// @brief add new state/action
    void add(data_type data);

    /// @brief remove oldest state/action
    void remove();

    /// @brief get_latest state/action
    data_type get_latest();

private:
    std::deque<data_type> buffer_data__;
    std::mutex mtx__;
};

/*
 * Implementation
 */
template <class data_type>
buffer<data_type>::buffer()
{}

template <class data_type>
void buffer<data_type>::add(data_type data)
{
    std::lock_guard<std::mutex> lock(mtx__);
    buffer_data__.push_back(data);
    remove();
}

template <class data_type>
void buffer<data_type>::remove()
{
    auto now = boost::chrono::system_clock::now();
    while ((boost::chrono::duration_cast<boost::chrono::milliseconds>(now - buffer_data__.front().state_time).count()) > 100 &&
           buffer_data__.size() > 1) {
         buffer_data__.pop_front();
    }  
}

template <class data_type>
data_type buffer<data_type>::get_latest()
{
    std::lock_guard<std::mutex> lock(mtx__);
    data_type empty;
    if (buffer_data__.size() == 0)
        return empty;
    return buffer_data__.back(); 
}

#endif
